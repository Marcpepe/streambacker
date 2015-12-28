import {Component} from 'angular2/core';
import {Streamer} from './streamer'
import {StreamerDetailsComponent} from './streamer-details.component'

@Component({
    selector: 'stbk-app',
    template: `
    <h1>{{ title }}</h1>
    <h2>My Streamers</h2>
    <ul class="streamers">
      <li [class.selected]="streamer === selectedStreamer" *ngFor="#streamer of streamers" (click)="onSelect(streamer)">
        <span class="badge">{{streamer.id}}</span> {{streamer.name}}
      </li>
    </ul>
    <streamer-details [streamer]="selectedStreamer"></streamer-details>
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
    directives: [StreamerDetailsComponent]
})

export class AppComponent {
  public title = 'Streambacker App';
  public streamers = STREAMERS;
  public selectedStreamer: Streamer;
  onSelect(streamer: Streamer) { this.selectedStreamer = streamer; }
}

var STREAMERS: Streamer[] = [
  { "id": 11, "name": "Trump" },
  { "id": 12, "name": "Sodapoppin" },
  { "id": 13, "name": "Lirik" },
  { "id": 14, "name": "Kolento" },
  { "id": 15, "name": "imaqtpie" },
];
