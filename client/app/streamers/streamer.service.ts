import {STREAMERS} from './mock-streamers';
import {Injectable} from 'angular2/core';

@Injectable()
export class StreamerService {
  getStreamers() {
    //return Promise.resolve(STREAMERS);
    return STREAMERS;
  }
}
