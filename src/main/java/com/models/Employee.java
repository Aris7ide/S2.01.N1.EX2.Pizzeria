package com.models;

public class Employee {

    private int id;
    private String name;
    private String surname;
    private String nif;
    private String phone;
    private String contract;
    private Shop shop; //chef or rider

    public Employee(String name, String surname, String nif, String phone, String contract, Shop shop) {
        this.name = name;
        this.surname = surname;
        this.nif = nif;
        this.phone = phone;
        this.contract = contract;
        this.shop = shop;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public String getNif() {
        return nif;
    }

    public void setNif(String nif) {
        this.nif = nif;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getContract() {
        return contract;
    }

    public void setContract(String contract) {
        this.contract = contract;
    }

    public Shop getShop() {
        return shop;
    }

    public void setShop(Shop shop) {
        this.shop = shop;
    }
}
