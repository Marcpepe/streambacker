import {Component, OnInit} from 'angular2/core';
import {RouteConfig, ROUTER_DIRECTIVES} from 'angular2/router';

import {Streamer} from './streamers/streamer'
import {StreamerService} from './streamers/streamer.service'
import {StreamerDetailsComponent} from './streamers/streamer-details.component'
import {AboutComponent} from './about.component'
import {MapToIterablePipe} from './map-to-iterable.pipe'

@Component({
    selector: 'stbk-app',
    template: `
    <h1>{{ title }}</h1>
    <h2>My Streamers</h2>
    <ul class="streamers">
      <li *ngFor="#streamer of streamers" [class.selected]="streamer === selectedStreamer" (click)="onSelect(streamer)">
        <span class="badge">{{streamer.id}}</span> {{streamer.name}}
      </li>
    </ul>
    <streamer-details [streamer]="selectedStreamer"></streamer-details>
    <h2>About</h2>
    <p>Learn more about the app <a [routerLink]="['About']">here</a>
    <router-outlet></router-outlet>
			`,
		styles:[`
			.streamers {list-style-type: none; margin-left: 1em; padding: 0; width: 10em;}
			.streamers li { cursor: pointer; position: relative; left: 0; transition: all 0.2s ease; }
			.streamers li:hover {color: #369; background-color: #EEE; left: .2em;}
			.streamers .badge {
				font-size: small;
				color: white;
				padding: 0.1em 0.7em;
				background-color: #369;
				line-height: 1em;
				position: relative;
				left: -1px;
				top: -1px;
			}
			.selected { background-color: #EEE; color: #369; }
		`],
    directives: [StreamerDetailsComponent, ROUTER_DIRECTIVES],
    providers: [StreamerService],
    pipes: [MapToIterablePipe]
})

@RouteConfig([
	{path:'/about',        name: 'About',       component: AboutComponent},
])

export class AppComponent {
  public title = 'Streambacker App';
  public streamers: any;
  public selectedStreamer: Streamer;

  constructor(private _streamerService: StreamerService) { }

  getStreamers() {
    //this.streamers = this._streamerService.getStreamers().then(streamers => this.streamers = streamers);
    this.streamers = this._streamerService.getStreamers();
  }

  ngOnInit() {
    this.getStreamers();
  }

  onSelect(streamer: Streamer) { this.selectedStreamer = streamer; }
}

