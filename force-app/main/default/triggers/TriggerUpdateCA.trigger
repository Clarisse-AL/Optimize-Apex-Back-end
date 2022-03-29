trigger TriggerUpdateCA on Account (after update) {

    List<Order> Order = new List<Order>();
    HelperTriggerUpdateCA.UpdateCa(order);

}