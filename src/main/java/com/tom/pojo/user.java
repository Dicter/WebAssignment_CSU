package com.tom.pojo;

public class user {
    private String username ;
    private String phoneNumber;
    private String password;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public String toString() {
        return "userInfor{" +
                "username='" + username + '\'' +
                ", phoneNumber='" + phoneNumber + '\'' +
                ", password='" + password + '\'' +
                '}';
    }

    public user(String username, String phoneNumber, String password) {
        this.username = username;
        this.phoneNumber = phoneNumber;
        this.password = password;
    }

    public user() {
    }

    public user(String username, String password){
        this.password=password;
        this.username=username;
        this.phoneNumber="LOGIN VIA ACCOUNT";
    }

    public user(String phoneNumber){
        this.password="LOGIN VIA PHONE";
        this.username="LOGIN VIA PHONE";
        this.phoneNumber=phoneNumber;
    }
}
