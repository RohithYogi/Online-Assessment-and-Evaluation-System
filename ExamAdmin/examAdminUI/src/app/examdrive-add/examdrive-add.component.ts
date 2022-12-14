import { Component, OnInit } from '@angular/core';
import {Examdrive} from '../shared/examdrive';
import {Course} from '../shared/course';
import {ExamdriveService} from '../services/examdrive.service';
import {CourseService} from '../services/course.service';
import { Params, ActivatedRoute, Router } from '@angular/router';
import {resetError, setError} from '../shared/error';

@Component({
  selector: 'app-examdrive-add',
  templateUrl: './examdrive-add.component.html',
  styleUrls: ['./examdrive-add.component.scss']
})
export class ExamdriveAddComponent implements OnInit {
  examdrive = {examdriveCode: null, examdriveName: null, status: 'NOT_STARTED', course: null};
  courses: Course[];
  selectedCourse: number;
  codes: string[];

  constructor(private examdriveService: ExamdriveService, private courseService: CourseService, public router: Router) { }

  ngOnInit(): void {
    this.getCourses();
    this.getCodes();
  }

  addExamdrive(examdrive: Examdrive): void{
    this.examdriveService.addExamdrive(examdrive).subscribe((examdrive)=>this.examdrive=examdrive);
  }

  getCourses(): void{
    this.courseService.getCourses().subscribe((courses) => {
      courses = courses.sort((obj1, obj2) => {
        if (obj1.courseCode > obj2.courseCode) {
            return 1;
        }
        if (obj1.courseCode < obj2.courseCode) {
            return -1;
        }
        return 0;
      });
      setTimeout(()=>{
        this.courses = courses;
      },500);
    });
  }

  getCourse(id: number): void{
    this.courseService.getCourse(id).subscribe((course) => this.examdrive.course  = course);
  }

  addCourse(){
    this.getCourse(this.selectedCourse);
  }

  getCodes(): void{
    this.examdriveService.getCodes().subscribe((codes) => this.codes=codes);
  }

  addDrive(){
    if(this.examdrive.examdriveName==null || this.examdrive.examdriveName==""){
      setError("examdriveName","Exam Drive name is Required");
    }
    else{
      resetError("examdriveName");
      if(this.examdrive.examdriveCode==null || this.examdrive.examdriveCode==""){
        setError("examdriveCode","Exam Drive code is Required");
      }
      else{
        resetError("examdriveCode");
        if(this.codes.includes(this.examdrive.examdriveCode)){
          setError("examdriveCode","This Examdrive Code is already taken");
        }
        else{
          resetError("examdriveCode")
          if(this.examdrive.course==null){
            setError("examdriveCourse","Course is Required");
          }
          else{
            this.addExamdrive(this.examdrive);
            setTimeout(() => {
              this.router.navigate(['/examdrives']);
            },1000);
          }
        }
      }
    }
  }

  onSubmit(){
    if(this.selectedCourse!=null){
      this.addCourse();
    }
    setTimeout(() => {
      this.addDrive();
    },500);
  }
}
