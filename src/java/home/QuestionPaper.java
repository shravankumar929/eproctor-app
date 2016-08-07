package home;
import java.util.ArrayList;

public class QuestionPaper
{
     Exam e;
     ArrayList<Question> que;
     public QuestionPaper(String exam_name,String description,int total_marks,int total_duration,String test_time,int num_of_que,int jumble)
     {
         e=new Exam();
         e.name=exam_name;
         e.description=description;
         e.total_marks=total_marks;
         e.total_duration=total_duration;
         e.start_time=test_time;
         e.no_of_que=num_of_que;
         e.jumble=jumble;
         que=new ArrayList<>();
     }
     public void addQue(int type,int QueNum,String description,int Marks,int negMarks,ArrayList<String> p,ArrayList<String> q)
     {
         Question obj=new Question();
         obj.que_no=QueNum;
         obj.type=type;
         obj.description=description;
         obj.p=p;
         obj.q=q;
         obj.Marks=Marks;
         obj.negMarks=negMarks;
         que.add(obj);
         
     }
     /*
     public String getExamName()
     {
         return e.name;
     }
     public int getTotalMarks()
     {
         return e.total_marks;
     }
     public int getDuration()
     {
         return e.total_duration;
     }
     public int getTotalNumberOfQuestions()
     {
         return que.size();
     }
     public String getQuestion(int i)
     {
         return que.get(i).description;
     }
     public int getQuestionType(int i)
     {
         return que.get(i).type;
     }
     public ArrayList<String> getOptionsP(int i)
     {
         return que.get(i).p;
     }
     public ArrayList<String> getOptionsQ(int i)
     {
         return que.get(i).q;
     }
     */
}
class Exam
{
     int no_of_que;
     int total_marks;
     int total_duration;
     String start_time;
     String name;
     String description;
     int jumble;
     
}
class Question
{
     int  type;
     int que_no;
     String description;
     int Marks;
     int negMarks;
     ArrayList<String> p;
     ArrayList<String> q;
}
