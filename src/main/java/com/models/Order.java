package com.models;

import java.time.LocalDateTime;
import java.util.*;

public class Order {

    private int id;
    private LocalDateTime orderDate;
    private Shop shop;
    private Client client;
    private boolean takeaway;
    private Employee employee; //only if takeaway
    private LocalDateTime orderReceived;
    private double totPrice;
    private List<Product> products;

    public Order(LocalDateTime orderDate, Shop shop, Client client, boolean takeaway,
                  double totPrice, List<Product> products) {
        this.orderDate = orderDate;
        this.shop = shop;
        this.client = client;
        this.takeaway = takeaway;
        this.totPrice = totPrice;
        this.products = products;
    }

    public Order(LocalDateTime orderDate, Shop shop, Client client, boolean takeaway,
                 Employee employee, LocalDateTime orderReceived, double totPrice, List<Product> products) {
        this.orderDate = orderDate;
        this.shop = shop;
        this.client = client;
        this.takeaway = takeaway;
        this.employee = employee;
        this.orderReceived = orderReceived;
        this.totPrice = totPrice;
        this.products = products;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public LocalDateTime getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(LocalDateTime orderDate) {
        this.orderDate = orderDate;
    }

    public Shop getShop() {
        return shop;
    }

    public void setShop(Shop shop) {
        this.shop = shop;
    }

    public Client getClient() {
        return client;
    }

    public void setClient(Client client) {
        this.client = client;
    }

    public boolean isTakeaway() {
        return takeaway;
    }

    public void setTakeaway(boolean takeaway) {
        this.takeaway = takeaway;
    }

    public Employee getEmployee() {
        return employee;
    }

    public void setEmployee(Employee employee) {
        this.employee = employee;
    }

    public LocalDateTime getOrderReceived() {
        return orderReceived;
    }

    public void setOrderReceived(LocalDateTime orderReceived) {
        this.orderReceived = orderReceived;
    }

    public double getTotPrice() {
        return totPrice;
    }

    public void setTotPrice(double totPrice) {
        this.totPrice = totPrice;
    }

    public List<Product> getProducts() {
        return products;
    }

    public void setProducts(List<Product> products) {
        this.products = products;
    }
}
