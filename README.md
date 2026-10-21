# PIZZERIA

## 📌 Enunciat del exercici
Te han contratado para diseñar una web que permita realizar pedidos de comida a domicilio por Internet.

Ten en cuenta las siguientes indicaciones para modelar cómo sería la base de datos del proyecto:
Para cada cliente/a almacenamos un identificador único:
- Nombre.
- Apellidos.
- Dirección.
- Código postal.
- Localidad.
- Provincia.
- Número de teléfono.

Los datos de localidad y provincia estarán almacenados en tablas separadas. Sabemos que una localidad pertenece a una única provincia y que una provincia puede tener muchas localidades. Para cada localidad se almacena un identificador único y un nombre. En cada provincia almacenamos un identificador único y un nombre.
- Una persona puede realizar muchos pedidos, pero un único pedido sólo puede ser realizado por una única persona. 
- De cada pedido se almacena un identificador único:
- Fecha/hora.
- Si el pedido es para reparto a domicilio o para recogerlo en tienda.
- La cantidad de productos que se han seleccionado de cada tipo.
- El precio total.
- Un pedido puede constar de uno o varios productos.


Los productos pueden ser pizzas, hamburguesas y bebidas. 
- De cada producto se almacena un identificador único:
- Nombre.
- Descripción.
- Imagen.
- Precio.

En el caso de las pizzas existen varias categorías que pueden cambiar de nombre a lo largo del año. Una pizza sólo puede estar dentro de una categoría, pero una categoría puede tener muchas pizzas.

De cada categoría se almacena un identificador único y un nombre. 

Un pedido es gestionado por una única tienda y una tienda puede manejar muchos pedidos. 

De cada tienda se almacena un identificador único:
- Dirección.
- Código postal.
- Localidad.
- Provincia.

En una tienda pueden trabajar muchos empleados y un empleado sólo puede trabajar en una tienda. 

De cada empleado/a, se almacena un identificador único:
- Nombre.
- Apellidos.
- NIF.
- Teléfono.
- Si trabaja como cocinero/ao repartidor/a. 

Para los pedidos de reparto a domicilio interesa guardar quién es el repartidor/a que hace la entrega del pedido y la fecha/hora del momento de la entrega.

## ✨ Funcionalitats
- Base de Datos/MySQL

## 🛠 Tecnologies
- **Llenguatge**: Java 25
- **IDE**: IntelliJ IDEA
- Docker
- mySQL Workbench

## Execution
- he creado todas las clases y el scheme.sql con las instrucciones para crear todas las tablas
- he creato RegionRepository y TownRepository para guardar los objetos en las tablas
- con RepositoryTest estoy haciendo las pruebas para verificar que se guarden
- he creado todos los repository menos ListOrder y Order
- he creado una clase ListOrder y en el constructor especificado que el totalPrice es la suma de todos los productos.
- en Order he creado la List<ListOrder> y especificado en un metodo el calculo del total del orden sumando todos los ListOrder de ese pedido.
- 