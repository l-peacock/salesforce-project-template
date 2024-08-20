---
layout: default
---
# virtual TriggerHandler

TriggerHandler Virtual Class


**Source** https://github.com/kevinohara80/sfdc-trigger-framework


**Group** Trigger

## Constructors
### `public TriggerHandler()`

Constructor to instantiate a trigger handler

---
## Methods
### `public void run()`

This method is the main 'execution' of a trigger. It is responsible for classing the various methods throughout the lifecycle of a trigger.

### `public void setMaxLoopCount(Integer max)`

Configure a maximum 'recursion' for a trigger

#### Parameters

|Param|Description|
|---|---|
|`max`|The maximum number of recursions allowed|

#### Example
```apex
MyTriggerHandler.setMaxLoopCount(1);
```


### `public void clearMaxLoopCount()`

Remove the maximum 'recursion' for a trigger

#### Example
```apex
MyTriggerHandler.clearMaxLoopCount();
```


### `public static void bypass(String handlerName)`

Add a specific handler to the bypass list

#### Parameters

|Param|Description|
|---|---|
|`handlerName`||

#### Example
```apex
MyTriggerHandler.bypass('myHandlerName');
```


### `public static void clearBypass(String handlerName)`

Remove a specific handler from the bypass list

#### Parameters

|Param|Description|
|---|---|
|`handlerName`||

#### Example
```apex
MyTriggerHandler.clearBypass('myHandlerName');
```


### `public static Boolean isBypassed(String handlerName)`

Helper to check if a specific handler is in the bypass list

#### Parameters

|Param|Description|
|---|---|
|`handlerName`||

#### Returns

|Type|Description|
|---|---|
|`Boolean`|Boolean|

#### Example
```apex
MyTriggerHandler.isBypassed('myHandlerName');
```


### `public static void clearAllBypasses()`

Empties all handlers from the bypass list

#### Example
```apex
MyTriggerHandler.clearAllBypasses();
```


---
## Classes
### TriggerHandlerException

Custom exception for TriggerHandler-specific exceptions


**Inheritance**

TriggerHandlerException


---
