CREATE TABLE IF NOT EXISTS tiendas (
    nif VARCHAR(30) NOT NULL,
    nombre VARCHAR(20),
    direccion VARCHAR(20),
    poblacion VARCHAR(20),
    provincia VARCHAR(20),
    codpostal NUMBER(5)
    PRIMARY KEY (nif)
)
ALTER TABLE tiendas 
ADD CONSTRAINT pk_tiendas PRIMARY KEY (nif);

ALTER TABLE tiendas 
MODIFY nombre VARCHAR(30) NOT NULL;

CREATE TABLE IF NOT EXISTS fabricantes (
    cod_fabricante NUMBER(3),
    nombre VARCHAR(15),
    pais VARCHAR(15)
    PRIMARY KEY (cod_fabricante) AUTO_INCREMENT
)
CREATE TABLE IF NOT EXISTS articulos (
    articulo VARCHAR(20),
    cod_fabricante NUMBER(3),
    peso INT UNSIGNED,
    categoria VARCHAR(10),
    precio_venta DECIMAL(7,2),
    precio_costo DECIMAL(7,2),
    exitencias INT UNSIGNED,
    PRIMARY KEY (articulo, cod_fabricant, peso, categoria),
    CONSTRAINT fk_cod_fabricante FOREIGN KEY (cod_fabricante) REFERENCES fabricantes(cod_fabricante),
    CONSTRAINT chk_precio_venta CHECK (precio_venta > 0),
    CONSTRAINT chk_precio_costo CHECK (precio_costo > 0),
    CONSTRAINT chk_peso CHECK (peso > 0),
    CONSTRAINT chk_categoria CHECK (categoria IN ('Primera', 'Segunda', 'Tercera'))

CREATE TABLE IF NOT EXISTS ventas (
    nif VARCHAR(10)
    articulo VARCHAR(20)
    cod_fabricante INT UNSIGNED
    peso INT UNSIGNED
    categoria VARCHAR(10)
    fecha_venta DATE
    unidades_vendidas INT UNSIGNED
    PRIMARY KEY (nif, articulo, cod_fabricante, peso, categoria, fecha_venta),
    CONSTRAINT fk_nif_ventas FOREIGN KEY (nif) REFERENCES tiendas(nif),
    CONSTRAINT fk_articulo_ventas FOREIGN KEY (articulo, cod_fabricante, peso, categoria)
    REFERENCES articulos(articulo, cod_fabricante, peso, categoria),
    CONSTRAINT chk_unidades_vendidas CHECK (unidades_vendidas > 0),
    CONSTRAINT chk_categoria_ventas CHECK (categoria IN ('Primera', 'Segunda', 'Tercera'))

)
CREATE TABLE IF NOT EXISTS pedidos (
    nif VARCHAR(10),
    articulo VARCHAR(20),
    cod_fabricante INT UNSIGNED,
    peso INT UNSIGNED,
    categoria VARCHAR(20),
    fecha_pedido DATE,
    unidades_pedidas SMALLINT UNSIGNED,
    exitencias INT UNSIGNED,
    PRIMARY KEY (nif, articulo, cod_fabricante, peso, categoria, fecha_pedido),
    CONSTRAINT fk_nif_pedidos FOREIGN KEY (nif) REFERENCES tiendas(nif),
    CONSTRAINT fk_articulo_pedidos FOREIGN KEY (articulo, cod_fabricante, peso, categoria)
    REFERENCES articulos(articulo, cod_fabricante, peso, categoria),
    CONSTRAINT chk_unidades_pedidas CHECK (unidades_pedidas > 0),
    CONSTRAINT chk_categoria_pedidos CHECK (categoria IN ('Primera', 'Segunda', 'Tercera'))
);
)
ALTER TABLE articulos 
MODIFY precio_venta DECIMAL(8,2),
MODIFY precio_costo DECIMAL(8,2);

ALTER TABLE pedidos 
ADD fecha_entrega DATE NULL;