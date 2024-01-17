IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

CREATE TABLE [Customers] (
    [CustomerID] int NOT NULL IDENTITY,
    [CustomerName] nvarchar(100) NULL,
    CONSTRAINT [PK_Customers] PRIMARY KEY ([CustomerID])
);
GO

CREATE TABLE [FoodItems] (
    [FoodItemId] int NOT NULL IDENTITY,
    [FoodItemName] nvarchar(100) NULL,
    [Price] decimal(18,2) NOT NULL,
    CONSTRAINT [PK_FoodItems] PRIMARY KEY ([FoodItemId])
);
GO

CREATE TABLE [OrderMasters] (
    [OrderMasterId] bigint NOT NULL IDENTITY,
    [OrderNumber] nvarchar(75) NULL,
    [CustomerId] int NOT NULL,
    [PMethod] nvarchar(10) NULL,
    [GTotal] decimal(18,2) NOT NULL,
    CONSTRAINT [PK_OrderMasters] PRIMARY KEY ([OrderMasterId]),
    CONSTRAINT [FK_OrderMasters_Customers_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [Customers] ([CustomerID]) ON DELETE CASCADE
);
GO

CREATE TABLE [OrderDetails] (
    [OrderDetailId] bigint NOT NULL IDENTITY,
    [OrderMasterId] bigint NOT NULL,
    [FoodItemId] int NOT NULL,
    [FoodItemPrice] decimal(18,2) NOT NULL,
    [Quantity] int NOT NULL,
    CONSTRAINT [PK_OrderDetails] PRIMARY KEY ([OrderDetailId]),
    CONSTRAINT [FK_OrderDetails_FoodItems_FoodItemId] FOREIGN KEY ([FoodItemId]) REFERENCES [FoodItems] ([FoodItemId]) ON DELETE CASCADE,
    CONSTRAINT [FK_OrderDetails_OrderMasters_OrderMasterId] FOREIGN KEY ([OrderMasterId]) REFERENCES [OrderMasters] ([OrderMasterId]) ON DELETE CASCADE
);
GO

CREATE INDEX [IX_OrderDetails_FoodItemId] ON [OrderDetails] ([FoodItemId]);
GO

CREATE INDEX [IX_OrderDetails_OrderMasterId] ON [OrderDetails] ([OrderMasterId]);
GO

CREATE INDEX [IX_OrderMasters_CustomerId] ON [OrderMasters] ([CustomerId]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20240117092950_InitialCreate', N'7.0.2');
GO

COMMIT;
GO

