/**
 * CaseTrigger
 * @description Trigger Description
 * @group Trigger Group
 */
trigger CaseTrigger on Case(
  before insert,
  after insert,
  before update,
  after update,
  before delete,
  after delete,
  after undelete
) {
  // Execute Trigger logic via the Trigger Handler framework
  new CaseTriggerHandler().run();
}
