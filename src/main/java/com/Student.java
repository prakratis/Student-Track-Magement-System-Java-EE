package com;

// Import statements if any...

public class Student {

    // --- 1. Fields ---
    private int id;
    private String name;
    private int age;
    private String className;
    private String sessionYear;
    private String username;
    private String password;
    private byte[] photo;
    private String photoType; 
    private String admissionStatus;

    // --- 2. Constructor ---
    public Student() {}

    // --- 3. Getters ---
    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public int getAge() {
        return age;
    }

    public String getClassName() {
        return className;
    }

    public String getSessionYear() {
        return sessionYear;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }
    
    public byte[] getPhoto() {
        return photo;
    }
    
    public String getPhotoType() {
        return photoType;
    }

    public String getAdmissionStatus() {
        return admissionStatus;
    }

    // --- 4. Setters ---
    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public void setSessionYear(String sessionYear) {
        this.sessionYear = sessionYear;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setPhoto(byte[] photo) {
        this.photo = photo;
    }

    public void setPhotoType(String photoType) {
        this.photoType = photoType;
    }

    public void setAdmissionStatus(String admissionStatus) {
        this.admissionStatus = admissionStatus;
    }
}
