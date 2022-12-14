import { FormGroup, FormControl, FormArray, FormBuilder } from '@angular/forms'
import { ItemServiceService } from '../service/itemService.service';
import { ItemFilterServiceService } from '../service/item-filter-service.service';
import { Router } from '@angular/router';
import * as ClassicEditor from '@ckeditor/ckeditor5-build-classic';
import { HttpParams } from '@angular/common/http';
import { QP } from '../shared/QP'
import {QPServiceService} from '../service/qpservice.service'
import { Component, OnInit } from '@angular/core';
import * as $ from 'jquery';
import { Item } from "../shared/item";


import { ChartsModule } from 'ng2-charts';
import { Chart } from 'chart.js';
import { course } from '../shared/course';
 


  
@Component({
  selector: 'my-app',
  templateUrl: './question-paper.component.html',
  styleUrls: [ './question-paper.component.css' ]
})
export class QuestionPaperComponent implements OnInit {


  // -----------------------------------------------------
  // ng init and constructor

  ngOnInit(): void {
    this.ItemService.getCourses().subscribe((courses)=> this.subject=courses);
    $('#QuestionPreviewModule').hide();
    $('#QPSetModule').hide();
    $('#successQP').hide();
    $('#errorQP').hide();
  }



  constructor(private ItemService: ItemServiceService,private ItemFilterService:ItemFilterServiceService,private router:Router,private QPService :QPServiceService,private fb:FormBuilder) {
    this.onFilterChange();
    this.refreshItems();
    this.onFilterChange = this.onFilterChange.bind(this);
    this.editQPList = this.editQPList.bind(this);
    this.productForm = this.fb.group({
      quantities: this.fb.array([])
    });
  }


// ng variables ------------------------------------------------

  selectedType: any = "";
  totalMarks: Number;
  instructions: string;
  selectedSub: course;
  ngType: any=true;
  testDuration: Number;
  endMark: Number=100;
  startMark: Number=1;
  noOfQuestions: Number;
  batchCode: string;
  subject:course[];
  messageQP: string;
  types = [
    { value: 'McqSingleCorrect', label: 'MCQ', checked: false },
    { value: 'True/False', label: 'TF', checked: false },
    { value: 'McqMultiCorrect', label: 'Multi Correct MCQ', checked: false }
  ];
  form: FormGroup;
  difLvl = [
    { value: 'EASY', label: 'EASY', checked: false},
    { value: 'EASY-MEDIUM', label: 'EASY-MEDIUM', checked: false},
    { value: 'MEDIUM', label: 'MEDIUM', checked: false },
    { value: 'HARD-MEDIUM', label: 'HARD-MEDIUM', checked: false },
    { value: 'HARD', label: 'HARD', checked: false },
  ];

  cgLvl = [
    { value: 'REMEMBER', label: 'REMEMBER', checked: false },
    { value: 'UNDERSTAND', label: 'UNDERSTAND', checked: false },
    { value: 'APPLY', label: 'APPLY', checked: false },
    { value: 'ANALYZE', label: 'ANALYZE', checked: false },
    { value: 'EVALUATE', label: 'EVALUATE', checked: false },
    { value: 'CREATE', label: 'CREATE', checked: false },
  ];


  //-----------------------------------------------------
  // other variables
  items=[];
  stats={
    "EASY": 0,
    "EASY-MEDIUM":0,
    "MEDIUM":0,
    "HARD-MEDIUM":0,
    "HARD":0,
    "McqSingleCorrect":0,
    "True/False":0,
    "McqMultiCorrect":0,
    "REMEMBER":0,
    "UNDERSTAND":0,
    "APPLY":0,
    "ANALYZE":0,
    "EVALUATE":0,
    "CREATE":0,
    "TotalQuestionsSelected":0,
    "TotalMarksSoFar":0
  };
  myQPSet = new Map(); // selected items in a hashmap --> <primaryKey,item>


  //-----------------------------------------------------
  get ordersFormArray() {
    return this.form.controls.orders as FormArray;
  }

  page = 1;
  pageSize = 10;
  collectionSize=3;
  author_id: Number=1;

  // qp:QP[];
  public Editor = ClassicEditor;
  public model = {
    editorData: '<p></p>'
  };


  // ------------------------------------------------------ 
  //* instructions *
  productForm: FormGroup;

  
  quantities() : FormArray {
    return this.productForm.get("quantities") as FormArray
  }
   
  newQuantity(): FormGroup {
    return this.fb.group({
      opt: '',
    })
  }
   
  addQuantity() {
    this.quantities().push(this.newQuantity());
  }
   
  removeQuantity(i:number) {
    this.quantities().removeAt(i);
  }


 //-------------------------------------------------------- 



//  add item/remove  in  myQPSet

  editQPList(item: Item){
      if(this.myQPSet.has(item.itemId))
      {
        this.myQPSet.delete(item.itemId); 
        this.stats[item.diffLvl]--; 
        this.stats[item.cgLvl]--;
        this.stats[item.itemType]--; 
        this.stats.TotalQuestionsSelected--;  
        this.stats.TotalMarksSoFar-=item.marks;
      }
      else
      {
        this.myQPSet.set(item.itemId,item);
        this.stats[item.diffLvl]++; 
        this.stats[item.cgLvl]++;
        this.stats[item.itemType]++; 
        this.stats.TotalQuestionsSelected++;  
        this.stats.TotalMarksSoFar+=item.marks;
      }
  }

  checked(item:Item)
  {
    if(this.myQPSet.has(item.itemId))
      return true;
    else
      return false;
  }


  // filtered questions display 

  onFilterChange() {
    var params = new HttpParams();
    // difLvl
    var difLvlArray=[]; 
    this.difLvl.forEach(function (value) {
      if(value.checked==true)
        difLvlArray.push(value.value);
    }); 
    if(difLvlArray.length==0)
    {
      this.difLvl.forEach(function (value) {
          difLvlArray.push(value.value);
      }); 
    }
    params = params.set('difLvl',difLvlArray.join(','));


    // cgLvlvar difLvlArray=[]; 
    var cgLvlArray=[]; 
    this.cgLvl.forEach(function (value) {
      if(value.checked==true)
        cgLvlArray.push(value.value);
    });
    if(cgLvlArray.length==0)
    {
      this.cgLvl.forEach(function (value) {
          cgLvlArray.push(value.value);
      });
    } 
    params = params.append('cgLvl', cgLvlArray.join(','));


    // types
    var typesArray=[]; 
    this.types.forEach(function (value) {
      if(value.checked==true)
      typesArray.push(value.value);
    });
    if(typesArray.length==0)
    {
      this.types.forEach(function (value) {
        typesArray.push(value.value);
      });
    }  
    params = params.set('types', typesArray.join(','));


    // subject
    if(this.selectedSub )
    {
      params = params.set('subject',(this.selectedSub.courseMasterId).toString());
      console.log(this.selectedSub);
      console.log(this.selectedSub.courseMasterId);
    }
    console.log("filter");

    
    // start marks;
    if(this.startMark!=null)
    params = params.set('startMark',JSON.stringify(this.startMark));
    else
    params = params.set('startMark',JSON.stringify(0));


    // end marks;
    if(this.endMark!=null)
    params = params.set('endMark',JSON.stringify(this.endMark));
    else
    params = params.set('endMark',JSON.stringify(100));

    // console.log(params);
    this.getItemFilter(params);
  }

  ngOnChanges() {
    // console.log(this.items);
  }

  stringToHTML(id, str) {
    var parser = new DOMParser();
    var doc = parser.parseFromString(str, 'text/html');
    // console.log(str);
    document.getElementById(id).innerHTML = str;
  };

  refreshItems() {
    this.items
    .map((item, i) => ({id: i + 1, ...item}))
      .slice((this.page - 1) * this.pageSize, (this.page - 1) * this.pageSize + this.pageSize);
  }




  // retrieval of questions based on filters 
  getItemFilter(parmas): void{
    this.ItemFilterService.getitemFilter(parmas).subscribe((items)=> this.items=items);
  }


  displayStat(s:string): string{
      if(this.stats[s]!=0)
        return "("+this.stats[s]+")";
      else
        return "";
  }

  routeToQpPreview(){
    $('#QuestionSeletionModule').hide();
    $('#QuestionPreviewModule').show();
    $('#QPSetModule').hide();
    this.resetStatus();
    this.chartDatasetsDifLvl[0].data=[this.stats.EASY, this.stats["EASY-MEDIUM"], this.stats.MEDIUM, this.stats["HARD-MEDIUM"], this.stats.HARD];
    this.chartDatasetsCgLvl[0].data=[this.stats.REMEMBER, this.stats.UNDERSTAND, this.stats.APPLY, this.stats.ANALYZE, this.stats.EVALUATE,this.stats.CREATE];
    this.chartDatasetsType[0].data=[this.stats.McqSingleCorrect, this.stats.McqMultiCorrect, this.stats["True/False"]];
  }

  resetStatus() {
    $('#createQP').show();
    $('#errorQP').hide();
    $('#successQP').hide();
    var popup = document.getElementById("myPopupSuccess");
    popup.style.visibility = 'hidden';
    var popup = document.getElementById("myPopupFailure");
    popup.style.visibility = 'hidden';
  }


  

// ----------------------------------------------------------   Question Paper Preview -----------------------------------------------


routeToQuestionsDisplay(){
  $('#QuestionSeletionModule').show();
  $('#QuestionPreviewModule').hide();
  $('#QPSetModule').hide();
  this.resetStatus();
}

routeToQPSet(){
  $('#QuestionSeletionModule').hide();
  $('#QuestionPreviewModule').hide();
  $('#QPSetModule').show();
  this.resetStatus();
}


deleteItem(item:Item){
  if(this.myQPSet.has(item.itemId))
    this.myQPSet.delete(item.itemId); 
  
}

// ----------------------------------------------------------   Question Paper stats -----------------------------------------------


public chartType: string = 'pie';

  // pie chart dif Lvl
  public chartDatasetsDifLvl: Array<any> = [
    { data: [this.stats.EASY, this.stats["EASY-MEDIUM"], this.stats.MEDIUM, this.stats["HARD-MEDIUM"], this.stats.HARD], label: 'DifLvl' }
  ];
  public chartLabelsDifLvl: Array<any> = ['EASY', 'EASY-MEDIUM', 'MEDIUM', 'HARD-MEDIUM', 'HARD'];



  // pie chart cg level
  public chartDatasetsCgLvl: Array<any> = [
    { data: [this.stats.REMEMBER, this.stats.UNDERSTAND, this.stats.APPLY, this.stats.ANALYZE, this.stats.EVALUATE,this.stats.CREATE], label: 'CgLvl' }
  ];
  public chartLabelsCgLvl: Array<any> = ['REMEMBER', 'UNDERSTAND', 'APPLY', 'ANALYZE', 'EVALUATE','CREATE'];


  // pie chart type
  //// McqSingleCorrect , McqMultiCorrect ,True/False

  public chartDatasetsType: Array<any> = [
    { data: [this.stats.McqSingleCorrect, this.stats.McqMultiCorrect, this.stats["True/False"]] }
  ];
  public chartLabelsType: Array<any> = ['Mcq Single Correct', 'Mcq Multi Correct', 'True/False'];



  public chartColors: Array<any> = [
    {
      backgroundColor: ['#F7464A', '#46BFBD', '#FDB45C', '#949FB1', '#4D5360'],
      hoverBackgroundColor: ['#FF5A5E', '#5AD3D1', '#FFC870', '#A8B3C5', '#616774'],
      borderWidth: 2,
    }
  ];
  public chartOptions: any = {
    responsive: true
  };
  public chartClicked(e: any): void { }
  public chartHovered(e: any): void { }

  handleError() {
    console.log("error");
    $('#errorQP').show();
    $('#createQP').hide();
    var popup = document.getElementById("myPopupFailure");
    popup.style.visibility = 'visible';
  }
  
  handleSuccess() {
    console.log("success");
    $('#successQP').show();
    $('#createQP').hide();
    var popup = document.getElementById("myPopupSuccess");
    popup.style.visibility = 'visible';
  }
  
  // create question paper
  setQP() {
    if(!this.selectedSub || !this.totalMarks || !this.testDuration || !this.batchCode || this.totalMarks!=this.stats.TotalMarksSoFar)
    {
      if(!this.selectedSub )
        this.messageQP = "Subject field not selected";
      else if(!this.totalMarks)
        this.messageQP = "Total Marks field is Empty";
      else if(!this.testDuration)
        this.messageQP = "Test Duration field is Empty";
      else if(!this.batchCode)
        this.messageQP = "Batch Code field is Empty";
      else if(this.totalMarks!=this.stats.TotalMarksSoFar)
        this.messageQP = "Total marks not equal to marks so far";

      this.handleError();
    } else {
        let myitems: Item[] = [];
        for (let value of this.myQPSet.values()) {
          myitems.push(value);    
        }
        let myInstructions: string[] = [];
        for (let key in this.productForm.value.quantities) { 
          if (this.productForm.value.quantities.hasOwnProperty(key)) { 
              let value = this.productForm.value.quantities[key]; 
              myInstructions.push(value.opt);
          } 
      } 
        console.log("set question Paper");
        this.QPService.setQP(this.selectedSub,this.totalMarks,this.testDuration,myitems,this.batchCode,myInstructions).subscribe((items)=> console.log(items));
        this.messageQP = "Question Paper set Sucessfully";
        this.handleSuccess();
      }
  
    }
}