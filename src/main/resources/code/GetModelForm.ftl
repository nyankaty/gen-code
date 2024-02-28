package ${modelPackage};

import java.util.List;

/**
* ${title}
*
* @author ${author}
* @version ${version}
*/
public class Get${modelClassName} {

    private int error;
    private String messageTitle;
    private String message;
    private List<${modelClassName}> data;

    public Get${modelClassName}() {

    }

    public Get${modelClassName}(int error, String messageTitle, String message) {
        this.error = error;
        this.messageTitle = messageTitle;
        this.message = message;
    }

    public Get${modelClassName}(int error, String messageTitle, String message, List<${modelClassName}> data) {
        this.error = error;
        this.messageTitle = messageTitle;
        this.message = message;
        this.data = data;
    }

    public int getError() {
        return error;
    }

    public void setError(int error) {
        this.error = error;
    }

    public String getMessageTitle() {
        return messageTitle;
    }

    public void setMessageTitle(String messageTitle) {
        this.messageTitle = messageTitle;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public List<${modelClassName}> getData() {
        return data;
    }

    public void setData(List<${modelClassName}> data) {
        this.data = data;
    }
}
