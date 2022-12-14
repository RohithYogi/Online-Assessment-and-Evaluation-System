import { Injectable } from '@angular/core';
import {Examdrive} from '../shared/examdrive';
import {EXAMDRIVES} from '../shared/examdrives';
import { HttpClient } from '@angular/common/http';
import {baseURL} from '../shared/baseurl';
import {Observable, of} from 'rxjs';
import { delay } from 'rxjs/operators';

@Injectable({
  providedIn: 'root'
})
export class ExamdriveService {
  constructor(private http: HttpClient) { }

  getExamdrives(): Observable<Examdrive[]>{
    // return of(EXAMDRIVES).pipe(delay(2000));
    return this.http.get<Examdrive[]>(baseURL + 'examdrives');
  }
  deleteExamdrive(id: number): Observable<any>{
    return this.http.delete<any>(baseURL+'examdrives/'+id);
  }
  addExamdrive(examdrive: Examdrive): Observable<Examdrive>{
    return this.http.post<Examdrive>(baseURL + 'examdrives',examdrive);
  }
  getExamdrive(id: number): Observable<Examdrive>{
    return this.http.get<Examdrive>(baseURL+'examdrives/'+id);
  }
  updateExamdrive(id: number, examdrive: Examdrive): Observable<Examdrive>{
    return this.http.put<Examdrive>(baseURL + "examdrives/" + id, examdrive);
  }
  getCodes(): Observable<string[]>{
    return this.http.get<string[]>(baseURL + 'examdriveCodes/');
  }
}
