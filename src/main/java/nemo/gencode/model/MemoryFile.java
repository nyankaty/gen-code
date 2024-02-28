package nemo.gencode.model;

public class MemoryFile {

    public String fileName;
    public byte[] contents;

    public MemoryFile(String fileName, byte[] contents) {
        this.fileName = fileName;
        this.contents = contents;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public byte[] getContents() {
        return contents;
    }

    public void setContents(byte[] contents) {
        this.contents = contents;
    }
}
