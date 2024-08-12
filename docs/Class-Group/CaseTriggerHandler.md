---
layout: default
---
# CaseTriggerHandler

CaseTriggerHandler


**Inheritance**

[TriggerHandler](../Trigger/TriggerHandler.md)
 &gt; 
CaseTriggerHandler


**Group** Class Group

## Constructors
### `public CaseTriggerHandler()`

**Constructor** 

---
## Methods
### `public override void beforeInsert()`
### `public override void afterInsert()`
### `public override void beforeUpdate()`
### `public void run()`

*Inherited*


This method is the main 'execution' of a trigger. It is responsible for classing the various methods throughout the lifecycle of a trigger.

#### Returns

|Type|Description|
|---|---|
|`void`|void|

### `public void setMaxLoopCount(Integer max)`

*Inherited*


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

*Inherited*


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

*Inherited*


Add a specific handler to the bypass list

#### Parameters

|Param|Description|
|---|---|
|`handlerName`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|

#### Example
```apex
MyTriggerHandler.bypass('myHandlerName');
```


### `public static void clearBypass(String handlerName)`

*Inherited*


Remove a specific handler from the bypass list

#### Parameters

|Param|Description|
|---|---|
|`handlerName`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|

#### Example
```apex
MyTriggerHandler.clearBypass('myHandlerName');
```


### `public static Boolean isBypassed(String handlerName)`

*Inherited*


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

*Inherited*


Empties all handlers from the bypass list

#### Returns

|Type|Description|
|---|---|
|`void`|void|

#### Example
```apex
MyTriggerHandler.clearAllBypasses();
```


---
