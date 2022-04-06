trigger TriggerUpdateCA on Account (after update) {

    List<Order> order = new List<Order>();
    HelperTriggerUpdateCA.UpdateCa(order);

}