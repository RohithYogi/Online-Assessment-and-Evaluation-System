import { Component, OnInit } from '@angular/core';
import {Center} from '../shared/center';
import {CenterService} from '../services/center.service';
import {Observable, of} from 'rxjs';

@Component({
  selector: 'app-center',
  templateUrl: './center.component.html',
  styleUrls: ['./center.component.scss']
})
export class CenterComponent implements OnInit {
  centers: Center[];
  constructor(private centerService:CenterService) { }

  ngOnInit(): void {
    this.centerService.getCenters().subscribe((centers) => this.centers = centers);
  }
}
