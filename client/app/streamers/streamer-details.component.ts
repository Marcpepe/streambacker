import {Component} from 'angular2/core';
import {Streamer} from './streamer'

@Component({
  selector: 'streamer-details',
  template: `
    <div *ngIf="streamer">
			<h2>{{streamer.name}} Details!</h2>
			<div><label>id: </label>{{streamer.id}}</div>
			<div>
				<label>name: </label>
				<input [(ngModel)]="streamer.name" placeholder="name"/>
			</div>
		</div>
  `,
  inputs: ['streamer']
})

export class StreamerDetailsComponent {
  public streamer: Streamer;
}
