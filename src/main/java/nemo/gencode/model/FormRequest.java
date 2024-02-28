package nemo.gencode.model;

public class FormRequest {

    private String apiUrl;
    private String controllerPath;
    private String daoPath;
    private String layerPath;
    private String modelPath;
    private String title;
    private String author;
    private String version;

    public FormRequest(String apiUrl, String controllerPath, String daoPath, String layerPath, String modelPath, String title, String author, String version) {
        this.apiUrl = apiUrl;
        this.controllerPath = controllerPath;
        this.daoPath = daoPath;
        this.layerPath = layerPath;
        this.modelPath = modelPath;
        this.title = title;
        this.author = author;
        this.version = version;
    }

    public FormRequest() {

    }

    public String getApiUrl() {
        return apiUrl;
    }

    public void setApiUrl(String apiUrl) {
        this.apiUrl = apiUrl;
    }

    public String getControllerPath() {
        return controllerPath;
    }

    public void setControllerPath(String controllerPath) {
        this.controllerPath = controllerPath;
    }

    public String getDaoPath() {
        return daoPath;
    }

    public void setDaoPath(String daoPath) {
        this.daoPath = daoPath;
    }

    public String getLayerPath() {
        return layerPath;
    }

    public void setLayerPath(String layerPath) {
        this.layerPath = layerPath;
    }

    public String getModelPath() {
        return modelPath;
    }

    public void setModelPath(String modelPath) {
        this.modelPath = modelPath;
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
}
