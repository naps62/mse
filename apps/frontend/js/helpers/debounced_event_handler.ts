import * as _ from 'lodash';

interface IEvent {
  persist: {(): any},
}

const debouncedEventHandler = (func, delay) => {
  const debounced = _.debounce(func, delay);
  return function(e: IEvent) {
    e.persist();
    return debounced(e);
  }
}

export default debouncedEventHandler;
