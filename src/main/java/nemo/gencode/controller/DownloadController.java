package nemo.gencode.controller;

import freemarker.template.Template;
import freemarker.template.TemplateException;
import nemo.gencode.model.FormRequest;
import nemo.gencode.model.MemoryFile;
import nemo.gencode.model.TemplateModel;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

import java.io.*;
import java.lang.reflect.Field;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

@RestController
public class DownloadController {

    private static final Logger log = LoggerFactory.getLogger(DownloadController.class);

    @Autowired
    private FreeMarkerConfigurer freeMarkerConfigurer;

    @PostMapping("/download")
    public ResponseEntity<?> downloadSource(FormRequest formRequest) {
        try {
            // mapping data from request
            TemplateModel templateModel = TemplateModel.fromFormRequest(formRequest);
            Map<String, Object> modelMap = new HashMap<>();
            for (Field field : TemplateModel.class.getDeclaredFields()) {
                field.setAccessible(true);
                modelMap.put(field.getName(), field.get(templateModel));
            }

            // generate file
            List<MemoryFile> memoryFiles = new ArrayList<>();

            memoryFiles.add(this.createMemoryFile("web.xml", freeMarkerConfigurer.getConfiguration().getTemplate("web.ftl"), modelMap));
            memoryFiles.add(this.createMemoryFile(templateModel.getModelClassName() + ".java", freeMarkerConfigurer.getConfiguration().getTemplate("ModelForm.ftl"), modelMap));
            memoryFiles.add(this.createMemoryFile("Get" + templateModel.getModelClassName() + ".java", freeMarkerConfigurer.getConfiguration().getTemplate("GetModelForm.ftl"), modelMap));
            memoryFiles.add(this.createMemoryFile(templateModel.getLayerClassName() + ".java", freeMarkerConfigurer.getConfiguration().getTemplate("Layer.ftl"), modelMap));
            memoryFiles.add(this.createMemoryFile(templateModel.getDaoClassName() + ".java", freeMarkerConfigurer.getConfiguration().getTemplate("DAO.ftl"), modelMap));
            memoryFiles.add(this.createMemoryFile(templateModel.getControllerClassName() + ".java", freeMarkerConfigurer.getConfiguration().getTemplate("Controller.ftl"), modelMap));

            byte[] byteArrFile = createZipByteArray(memoryFiles);

            ByteArrayResource resource = new ByteArrayResource(byteArrFile);

            return ResponseEntity.ok()
                    .contentType(MediaType.APPLICATION_OCTET_STREAM)
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=Nemo_Generated_Source_"
                            + new SimpleDateFormat("yyyy-MM-dd_HH-mm-ss").format(new Date()) + ".zip")
                    .body(resource);
        } catch (Exception e) {
            e.printStackTrace();
            log.error(e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
    }

    private MemoryFile createMemoryFile(String fileName, Template template, Map<String, Object> modelMap) throws IOException, TemplateException {
        StringWriter sw = new StringWriter();
        template.process(modelMap, sw);
        return new MemoryFile(fileName, sw.toString().getBytes());
    }

    public byte[] createZipByteArray(List<MemoryFile> memoryFiles) throws IOException {
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();

        try (ZipOutputStream zipOutputStream = new ZipOutputStream(byteArrayOutputStream)) {
            for (MemoryFile memoryFile : memoryFiles) {
                ZipEntry zipEntry = new ZipEntry(memoryFile.fileName);
                zipOutputStream.putNextEntry(zipEntry);
                zipOutputStream.write(memoryFile.contents);
                zipOutputStream.closeEntry();
            }
        }

        return byteArrayOutputStream.toByteArray();
    }
}
