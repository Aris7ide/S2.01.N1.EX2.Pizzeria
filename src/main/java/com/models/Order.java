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
    private List<ListOrder> listOrders;

    public Order(Shop shop, Client client, boolean takeaway) {
        this.orderDate = LocalDateTime.now();
        this.shop = shop;
        this.client = client;
        this.takeaway = takeaway;
        this.listOrders = new ArrayList<>();
        this.totPrice = calculateTotalOrder();
    }

    public Order(Shop shop, Client client, boolean takeaway,
                 Employee employee, LocalDateTime orderReceived) {
        this.orderDate = LocalDateTime.now();
        this.shop = shop;
        this.client = client;
        this.takeaway = takeaway;
        this.employee = employee;
        this.orderReceived = orderReceived;
        this.listOrders = new ArrayList<>();
        this.totPrice = calculateTotalOrder();
    }

    public double calculateTotalOrder() {
        double total = this.listOrders.stream().mapToDouble(ListOrder::getTotalPrice).sum();
        this.totPrice = total;
        return total;
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

    public List<ListOrder> getProducts() {
        return listOrders;
    }

    public void setProducts(List<ListOrder> products) {
        this.listOrders = products;
    }
}
