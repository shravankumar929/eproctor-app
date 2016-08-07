package home;

import java.util.HashMap;

public class Answer 
{
    public String exam_name;
    public int num_of_que;
    HashMap<Integer,String> map=null;
    public Answer(String exam_name,int num_of_que)
    {
        this.exam_name=exam_name;
        this.num_of_que=num_of_que;
        map=new HashMap<>(num_of_que);
    }
    public void addAns(int que_num,String ans_positions)
    {
        map.put(que_num, ans_positions);
    }   
}

