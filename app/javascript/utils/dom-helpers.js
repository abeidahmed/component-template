export function disableEvent(domArray, eventName) {
  for (let domProp of domArray) {
    domProp.addEventListener(eventName, e => {
      e.preventDefault();
    });
  }
}
