<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://java.sun.com/xml/ns/j2ee" xmlns:web="http://xmlns.jcp.org/xml/ns/javaee" xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://java.sun.com/xml/ns/javaee/web-app_2_5.xsd http://java.sun.com/xml/ns/j2ee http://java.sun.com/xml/ns/j2ee/web-app_2_4.xsd" id="WebApp_ID" version="2.4">
    <display-name>NEMOAPI</display-name>

    <servlet>
        <description>
        </description>
        <display-name>${controllerClassName}</display-name>
        <servlet-name>${controllerClassName}</servlet-name>
        <servlet-class>${controllerClassPath}</servlet-class>
    </servlet>
    <servlet-mapping>
        <servlet-name>${controllerClassName}</servlet-name>
        <url-pattern>${apiUrl}</url-pattern>
    </servlet-mapping>

    <welcome-file-list>
        <welcome-file>index.html</welcome-file>
    </welcome-file-list>
</web-app>