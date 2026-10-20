package com.models;

public class Shop {

    private int id;
    private String address;
    private String postalCodeShop;
    private Town town;
    private Region region;

    public Shop(String address, String postalCodeShop, Town town, Region region) {
        this.address = address;
        this.postalCodeShop = postalCodeShop;
        this.town = town;
        this.region = region;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPostalCodeShop() {
        return postalCodeShop;
    }

    public void setPostalCodeShop(String postalCodeShop) {
        this.postalCodeShop = postalCodeShop;
    }

    public Town getTown() {
        return town;
    }

    public void setTown(Town town) {
        this.town = town;
    }

    public Region getRegion() {
        return region;
    }

    public void setRegion(Region region) {
        this.region = region;
    }
}
