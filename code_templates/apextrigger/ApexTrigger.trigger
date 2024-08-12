/**
 * <%= triggername %>
 * @description Trigger Description
 * @group Trigger Group
 */
trigger <%= triggername %> on <%= sobject %> (
  before insert,
  after insert,
  before update,
  after update,
  before delete,
  after delete,
  after undelete
) {
    // Execute Trigger logic via the Trigger Handler framework
    <%= sobject %>TriggerHandler.run();
}
