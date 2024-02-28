package nemo.gencode.model;

import nemo.gencode.utils.StringUtils;

public class TemplateModel {

    private String apiUrl;
    private String controllerClassPath;
    private String daoClassPath;
    private String layerClassPath;
    private String modelClassPath;
    private String title;
    private String author;
    private String version;

    private String controllerPackage;
    private String daoPackage;
    private String layerPackage;
    private String modelPackage;
    private String controllerClassName;
    private String daoClassName;
    private String layerClassName;
    private String modelClassName;

    private String sanitizationModelClassName;

    public static TemplateModel fromFormRequest(FormRequest fr) {
        TemplateModel templateModel = new TemplateModel();
        templateModel.setApiUrl(fr.getApiUrl());
        templateModel.setControllerClassPath(fr.getControllerPath());
        templateModel.setDaoClassPath(fr.getDaoPath());
        templateModel.setLayerClassPath(fr.getLayerPath());
        templateModel.setModelClassPath(fr.getModelPath());
        templateModel.setTitle(fr.getTitle());
        templateModel.setAuthor(fr.getAuthor());
        templateModel.setVersion(fr.getVersion());

        templateModel.setControllerClassName(fr.getControllerPath().substring(fr.getControllerPath().lastIndexOf(".") + 1));
        templateModel.setDaoClassName(fr.getDaoPath().substring(fr.getDaoPath().lastIndexOf(".") + 1));
        templateModel.setLayerClassName(fr.getLayerPath().substring(fr.getLayerPath().lastIndexOf(".") + 1));
        templateModel.setModelClassName(fr.getModelPath().substring(fr.getModelPath().lastIndexOf(".") + 1));

        templateModel.setControllerPackage(fr.getControllerPath().substring(0, fr.getControllerPath().lastIndexOf(".")));
        templateModel.setDaoPackage(fr.getDaoPath().substring(0, fr.getDaoPath().lastIndexOf(".")));
        templateModel.setLayerPackage(fr.getLayerPath().substring(0, fr.getLayerPath().lastIndexOf(".")));
        templateModel.setModelPackage(fr.getModelPath().substring(0, fr.getModelPath().lastIndexOf(".")));

        templateModel.setSanitizationModelClassName(StringUtils.getNormalNameFromClassName(templateModel.getModelClassName()));
        return templateModel;
    }

    public String getApiUrl() {
        return apiUrl;
    }

    public void setApiUrl(String apiUrl) {
        this.apiUrl = apiUrl;
    }

    public String getControllerClassPath() {
        return controllerClassPath;
    }

    public void setControllerClassPath(String controllerClassPath) {
        this.controllerClassPath = controllerClassPath;
    }

    public String getDaoClassPath() {
        return daoClassPath;
    }

    public void setDaoClassPath(String daoClassPath) {
        this.daoClassPath = daoClassPath;
    }

    public String getLayerClassPath() {
        return layerClassPath;
    }

    public void setLayerClassPath(String layerClassPath) {
        this.layerClassPath = layerClassPath;
    }

    public String getModelClassPath() {
        return modelClassPath;
    }

    public void setModelClassPath(String modelClassPath) {
        this.modelClassPath = modelClassPath;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    public String getControllerPackage() {
        return controllerPackage;
    }

    public void setControllerPackage(String controllerPackage) {
        this.controllerPackage = controllerPackage;
    }

    public String getDaoPackage() {
        return daoPackage;
    }

    public void setDaoPackage(String daoPackage) {
        this.daoPackage = daoPackage;
    }

    public String getLayerPackage() {
        return layerPackage;
    }

    public void setLayerPackage(String layerPackage) {
        this.layerPackage = layerPackage;
    }

    public String getModelPackage() {
        return modelPackage;
    }

    public void setModelPackage(String modelPackage) {
        this.modelPackage = modelPackage;
    }

    public String getControllerClassName() {
        return controllerClassName;
    }

    public void setControllerClassName(String controllerClassName) {
        this.controllerClassName = controllerClassName;
    }

    public String getDaoClassName() {
        return daoClassName;
    }

    public void setDaoClassName(String daoClassName) {
        this.daoClassName = daoClassName;
    }

    public String getLayerClassName() {
        return layerClassName;
    }

    public void setLayerClassName(String layerClassName) {
        this.layerClassName = layerClassName;
    }

    public String getModelClassName() {
        return modelClassName;
    }

    public void setModelClassName(String modelClassName) {
        this.modelClassName = modelClassName;
    }

    public String getSanitizationModelClassName() {
        return sanitizationModelClassName;
    }

    public void setSanitizationModelClassName(String sanitizationModelClassName) {
        this.sanitizationModelClassName = sanitizationModelClassName;
    }
}
