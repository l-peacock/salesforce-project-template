---
layout: default
---
# virtual TriggerHandler

TriggerHandler Virtual Class


**Source** https://github.com/kevinohara80/sfdc-trigger-framework


**Group** Trigger

## Constructors
### `public TriggerHandler()`

**Constructor** TriggerHandler

---
## Methods
### `public void run()`

This method is the main 'execution' of a trigger. It is responsible for classing the various methods throughout the lifecycle of a trigger.

#### Returns

|Type|Description|
|---|---|
|`void`|void|

### `public void setMaxLoopCount(Integer max)`

Configure a maximum 'recursion' for a trigger

#### Parameters

|Param|Description|
|---|---|
|`max`|The maximum number of recursions allowed|

#### Returns

|Type|Description|
|---|---|
|`void`|void|

#### Example
```apex
MyTriggerHandler.setMaxLoopCount(1);
```


### `public void clearMaxLoopCount()`

Remove the maximum 'recursion' for a trigger

#### Returns

|Type|Description|
|---|---|
|`void`|void|

#### Example
```apex
MyTriggerHandler.clearMaxLoopCount();
```


### `public static void bypass(String handlerName)`
### `public static void clearBypass(String handlerName)`
### `public static Boolean isBypassed(String handlerName)`
### `public static void clearAllBypasses()`
---
## Classes
### TriggerHandlerException

**Inheritance**

TriggerHandlerException


---
