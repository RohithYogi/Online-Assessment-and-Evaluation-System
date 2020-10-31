import { AppRoutingModule } from './app-routing.module';
import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppComponent } from './app.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { FlexLayoutModule } from '@angular/flex-layout';
import { QuestionPaperComponent } from './question-paper/question-paper.component';
import { HttpClientModule } from "@angular/common/http";
import { baseURL } from "./shared/baseurl";
import { InstructionComponent } from './instruction/instruction.component';
import { DatePipe } from '@angular/common'

import { QuestionPaperService } from "./services/question-paper.service";
import { InstructionService } from "./services/instruction.service";
import { ExaminationService } from "./services/examination.service";
import { ExaminationComponent } from './examination/examination.component';
import { HeaderComponent } from './header/header.component';
import { PackageManagementComponent } from './package-management/package-management.component';

@NgModule({
  declarations: [
    AppComponent,
    QuestionPaperComponent,
    InstructionComponent,
    ExaminationComponent,
    HeaderComponent,
    PackageManagementComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    BrowserAnimationsModule,
    MatCheckboxModule,
    FlexLayoutModule,
    HttpClientModule
  ],
  providers: [
    QuestionPaperService,
    InstructionService,
    ExaminationService,
    DatePipe,
    { provide: 'BaseURL', useValue: baseURL }
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
