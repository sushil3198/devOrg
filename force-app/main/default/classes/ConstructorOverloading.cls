public class ConstructorOverloading {

    public Integer rNo;
    public String name;
    
    public ConstructorOverloading(Integer rollNumber){ this.rNo = rollNumber; }
    public ConstructorOverloading(Integer rollNumber, String inputName)
    {
        this.rNo = rollNumber;
        this.name = inputName;
    }
    
    public void display()
    {
        System.debug(this.rNo);
        System.debug(this.name);
    }
}