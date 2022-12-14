import { Injectable } from '@angular/core';
import {Center} from '../shared/center';
import { HttpClient } from '@angular/common/http';
import {baseURL} from '../shared/baseurl';
import {Observable, of} from 'rxjs';
import { delay } from 'rxjs/operators';

@Injectable({
  providedIn: 'root'
})
export class CenterService {

  constructor(private http: HttpClient) { }

  getCenters(): Observable<Center[]>{
    return this.http.get<Center[]>(baseURL + 'centers');
  }

  deleteCenter(id: number): Observable<any>{
    return this.http.delete<any>(baseURL + 'centers/'+id);
  }

  getCenter(id: number): Observable<Center>{
    return this.http.get<Center>(baseURL + 'centers/'+id);
  }

  addCenter(center: Center): Observable<Center>{
    return this.http.post<Center>(baseURL + 'centers', center);
  }

  updateCenter(id: number, center: Center): Observable<Center>{
    return this.http.put<Center>(baseURL + 'centers/'+id, center);
  }

  getCodes(): Observable<string[]>{
    return this.http.get<string[]>(baseURL + 'centerCodes/');
  }
}
