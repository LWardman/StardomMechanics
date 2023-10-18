
# This Queue implementation is taken from https://dev.epicgames.com/community/snippets/rmpp/fortnite-generic-queue-implementation

Queue<public><constructor>(InitialElements:[]t where t:type) := queue(t):
    Elements := InitialElements

queue<public>(t:type) := class:
    Elements<internal>:[]t = array{}
 
    Enqueue<public>(NewElement:t):queue(t)=
        queue(t){Elements := Elements + array{NewElement}}
    
    Dequeue<public>()<decides><transacts>:tuple(queue(t),t)=
        FirstElement := Front[]
        (queue(t){Elements := Elements.RemoveElement[0]}, FirstElement)
 
    Size<public>()<transacts>:int=
        Elements.Length
    
    IsEmpty<public>()<decides><transacts>:void=
        Size() = 0
    
    Front<public>()<decides><transacts>:t=
        Elements[0]
    
    Rear<public>()<decides><transacts>:t=
        Elements[Elements.Length - 1]
