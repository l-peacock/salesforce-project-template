/**
 * TriggerHandler Virtual Class
 * @source https://github.com/kevinohara80/sfdc-trigger-framework
 * @description This class defines the base structure for a Trigger Handler class, and provides all the required context-specific methods.
 * @group Trigger
 */
public virtual class TriggerHandler {
  // Map of handlername, times run() was invoked
  private static Map<String, LoopCount> loopCountMap;
  private static Set<String> bypassedHandlers;

  // The current context of the trigger, overridable in tests
  @TestVisible
  private TriggerContext context;

  // The current context of the trigger, overridable in tests
  @TestVisible
  private Boolean isTriggerExecuting;

  // Static initialization of private variables
  static {
    loopCountMap = new Map<String, LoopCount>();
    bypassedHandlers = new Set<String>();
  }

  /**
   * @description Constructor to instantiate a trigger handler
   */
  public TriggerHandler() {
    this.setTriggerContext();
  }

  /**
   * @description This method is the main 'execution' of a trigger. It is responsible for classing the various methods throughout the lifecycle of a trigger.
   */
  public void run() {
    if (!validateRun()) {
      return;
    }

    addToLoopCount();

    // Dispatch to the correct handler method
    switch on this.context {
      when BEFORE_INSERT {
        this.beforeInsert();
      }
      when BEFORE_UPDATE {
        this.beforeUpdate();
      }
      when BEFORE_DELETE {
        this.beforeDelete();
      }
      when AFTER_INSERT {
        this.afterInsert();
      }
      when AFTER_UPDATE {
        this.afterUpdate();
      }
      when AFTER_DELETE {
        this.afterDelete();
      }
      when AFTER_UNDELETE {
        this.afterUndelete();
      }
    }
  }

  /**
   * @description Configure a maximum 'recursion' for a trigger
   * @param max The maximum number of recursions allowed
   * @example
   * MyTriggerHandler.setMaxLoopCount(1);
   */
  public void setMaxLoopCount(Integer max) {
    String handlerName = getHandlerName();
    if (!TriggerHandler.loopCountMap.containsKey(handlerName)) {
      TriggerHandler.loopCountMap.put(handlerName, new LoopCount(max));
    } else {
      TriggerHandler.loopCountMap.get(handlerName).setMax(max);
    }
  }

  /**
   * @description Remove the maximum 'recursion' for a trigger
   * @example
   * MyTriggerHandler.clearMaxLoopCount();
   */
  public void clearMaxLoopCount() {
    this.setMaxLoopCount(-1);
  }

  /**
   * @description Add a specific handler to the bypass list
   * @param handlerName
   * @example
   * MyTriggerHandler.bypass('myHandlerName');
   */
  public static void bypass(String handlerName) {
    TriggerHandler.bypassedHandlers.add(handlerName);
  }

  /**
   * @description Remove a specific handler from the bypass list
   * @param handlerName

   * @example
   * MyTriggerHandler.clearBypass('myHandlerName');
   */
  public static void clearBypass(String handlerName) {
    TriggerHandler.bypassedHandlers.remove(handlerName);
  }

  /**
   * @description Helper to check if a specific handler is in the bypass list
   * @param handlerName
   * @return Boolean
   * @example
   * MyTriggerHandler.isBypassed('myHandlerName');
   */
  public static Boolean isBypassed(String handlerName) {
    return TriggerHandler.bypassedHandlers.contains(handlerName);
  }

  /**
   * @description Empties all handlers from the bypass list
   * @example
   * MyTriggerHandler.clearAllBypasses();
   */
  public static void clearAllBypasses() {
    TriggerHandler.bypassedHandlers.clear();
  }

  /**
   * @description Sets an empty trigger context
   * @example
   * MyTriggerHandler.setTriggerContext();
   */
  @TestVisible
  private void setTriggerContext() {
    this.setTriggerContext(null, false);
  }

  /**
   * @description Overrides the trigger context, useful for test methods
   * @param ctx
   * @param testMode
   * @example
   * MyTriggerHandler.setTriggerContext('before insert', false);
   */
  @TestVisible
  private void setTriggerContext(String ctx, Boolean testMode) {
    if (!Trigger.isExecuting && !testMode) {
      this.isTriggerExecuting = false;
      return;
    } else {
      this.isTriggerExecuting = true;
    }

    if (
      (Trigger.isExecuting && Trigger.isBefore && Trigger.isInsert) ||
      (ctx != null &&
      ctx == 'before insert')
    ) {
      this.context = TriggerContext.BEFORE_INSERT;
    } else if (
      (Trigger.isExecuting && Trigger.isBefore && Trigger.isUpdate) ||
      (ctx != null &&
      ctx == 'before update')
    ) {
      this.context = TriggerContext.BEFORE_UPDATE;
    } else if (
      (Trigger.isExecuting && Trigger.isBefore && Trigger.isDelete) ||
      (ctx != null &&
      ctx == 'before delete')
    ) {
      this.context = TriggerContext.BEFORE_DELETE;
    } else if (
      (Trigger.isExecuting && Trigger.isAfter && Trigger.isInsert) ||
      (ctx != null &&
      ctx == 'after insert')
    ) {
      this.context = TriggerContext.AFTER_INSERT;
    } else if (
      (Trigger.isExecuting && Trigger.isAfter && Trigger.isUpdate) ||
      (ctx != null &&
      ctx == 'after update')
    ) {
      this.context = TriggerContext.AFTER_UPDATE;
    } else if (
      (Trigger.isExecuting && Trigger.isAfter && Trigger.isDelete) ||
      (ctx != null &&
      ctx == 'after delete')
    ) {
      this.context = TriggerContext.AFTER_DELETE;
    } else if (
      (Trigger.isExecuting && Trigger.isAfter && Trigger.isUndelete) ||
      (ctx != null &&
      ctx == 'after undelete')
    ) {
      this.context = TriggerContext.AFTER_UNDELETE;
    }
  }

  /**
   * @description Increments the loop count, tracks recursive executions of a trigger
   * @example
   * MyTriggerHandler.addToLoopCount();
   */
  @TestVisible
  private void addToLoopCount() {
    String handlerName = getHandlerName();
    if (TriggerHandler.loopCountMap.containsKey(handlerName)) {
      Boolean exceeded = TriggerHandler.loopCountMap.get(handlerName)
        .increment();
      if (exceeded) {
        Integer max = TriggerHandler.loopCountMap.get(handlerName).max;
        throw new TriggerHandlerException(
          'Maximum loop count of ' +
            String.valueOf(max) +
            ' reached in ' +
            handlerName
        );
      }
    }
  }

  /**
   * @description Validates that a Trigger can continue to run
   * @return Boolean
   * @example
   * MyTriggerHandler.validateRun();
   */
  @TestVisible
  private Boolean validateRun() {
    if (!this.isTriggerExecuting || this.context == null) {
      throw new TriggerHandlerException(
        'Trigger handler called outside of Trigger execution'
      );
    }
    return !TriggerHandler.bypassedHandlers.contains(getHandlerName());
  }

  /**
   * @description Helper to get the name of the currently executing trigger handler (i.e. the class extending `TriggerHandler`)
   * @return String
   * @example
   * MyTriggerHandler.getHandlerName();
   */
  @TestVisible
  private String getHandlerName() {
    return this.toString().substringBefore(':');
  }

  /**
   * @description Override this method with the trigger's `before insert` logic
   */
  @TestVisible
  // prettier-ignore
  protected virtual void beforeInsert() {}

  /**
   * @description Override this method with the trigger's `before update` logic
   */
  @TestVisible
  // prettier-ignore
  protected virtual void beforeUpdate() {}

  /**
   * @description Override this method with the trigger's `before delete` logic
   */
  @TestVisible
  // prettier-ignore
  protected virtual void beforeDelete() {}

  /**
   * @description Override this method with the trigger's `after insert` logic
   */
  @TestVisible
  // prettier-ignore
  protected virtual void afterInsert() {}

  /**
   * @description Override this method with the trigger's `after update` logic
   */
  @TestVisible
  // prettier-ignore
  protected virtual void afterUpdate() {}

  /**
   * @description Override this method with the trigger's `after delete` logic
   */
  @TestVisible
  // prettier-ignore
  protected virtual void afterDelete() {}

  /**
   * @description Override this method with the trigger's `after undelete` logic
   */
  @TestVisible
  // prettier-ignore
  protected virtual void afterUndelete() {}

  /**
   * @description Inner class for managing the loop count per handler
   */
  @TestVisible
  private class LoopCount {
    private Integer max;
    private Integer count;

    /**
     * @description Constructor to instantiate a LoopCount with the default maximum of 5
     */
    public LoopCount() {
      this.max = 5;
      this.count = 0;
    }

    /**
     * @description Constructor to instantiate a LoopCount with a maximum value
     * @param max
     */
    public LoopCount(Integer max) {
      this.max = max;
      this.count = 0;
    }

    /**
     * @description Increments the loop count by one. Returns true if the maximum count has been exceeded.
     * @return Boolean
     * @example
     * LoopCount.increment()
     */
    public Boolean increment() {
      this.count++;
      return this.exceeded();
    }

    /**
     * @description Returns true if the maximum count has been exceeded.
     * @return Boolean
     * @example
     * LoopCount.exceeded()
     */
    public Boolean exceeded() {
      return this.max >= 0 && this.count > this.max;
    }

    /**
     * @description Returns the maximum loop count allowed
     * @return Integer
     * @example
     * LoopCount.getMax()
     */
    public Integer getMax() {
      return this.max;
    }

    /**
     * @description Returns the current loop count
     * @return Integer
     * @example
     * LoopCount.getCount()
     */
    public Integer getCount() {
      return this.count;
    }

    /**
     * @description Sets the maximum loop count
     * @param max
     * @example
     * LoopCount.setMax(2)
     */
    public void setMax(Integer max) {
      this.max = max;
    }
  }

  /**
   * @description Defines the possible TriggerContext values
   */
  @TestVisible
  private enum TriggerContext {
    BEFORE_INSERT,
    BEFORE_UPDATE,
    BEFORE_DELETE,
    AFTER_INSERT,
    AFTER_UPDATE,
    AFTER_DELETE,
    AFTER_UNDELETE
  }

  /**
   * @description Custom exception for TriggerHandler-specific exceptions
   */
  public class TriggerHandlerException extends Exception {
  }
}
