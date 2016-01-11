import {Component} from 'angular2/core';

@Component({
  selector: 'about',
  template: `
    <h1>About</h1>
    <p>Streambacker is a completely free community building tool for streamers</p>
    <p>The application was created and is maintained by <span href="mailto:marc.perrinpelletier@gmail.com">Marc Perrin-Pelletier</span></p>
  `,
})

export class AboutComponent {
  public founder: string;
}
