import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Scanner;

/**
 * 
 * @author Xincheng Yang(xyang76@hawk.iit.edu)
 * @version 1.0
 * 
 * Actually, the attributes name and table name should stored in sys_table(such as user_cons_columns), 
 * but I stored in the header of each table files. 
 * 
 * Class Homework1 Methods: 
 * 	CartesianProduct: return a Cartesian product of two tables.
 * 	NaturalJoin : return a natural join of two tables.
 *  LeftOuterJoin : return a left outer join of two tables.
 *  
 * Class Table Methods:
 * 	print: print this table in Console.
 *  load: load this table by its file path.
 *  save: save this table by its file path.
 */
public class Homework1 {

	public static void main(String[] args) {
		new Homework1().run();
	}

	public static final String SEPARATOR = " ";
	public static String table1filepath = "E:\\table1.data";
	public static String table2filepath = "E:\\table2.data";
	
	public static final String TABLE1PATH_STRING = "Please input the file path of table1:";
	public static final String TABLE2PATH_STRING = "Please input the file path of table2:";
	public static final String COMMAND_DETAIL_STRING = "\nCommand detail[eg: Cartesian]\n" +
			"\tCartesian/C: do Cartesian product.\n" +
			"\tNatural/N: do natural join.\n" +
			"\tLeft/L: left outer join.\n" +
			"\tPrint/P: print the result in console.\n" +
			"\tSave/S [filepath]: save the result to a file.[eg: S E:\\result.data]\n" +
			"\tExit/E: exit.";
	public static final String COMMAND_STRING = "Please input a command:";

	public void run() {
		Scanner sc = new Scanner(System.in);
		Table t1 = null;
		Table t2 = null;
		
		while (true) {
			try {
				System.out.println(TABLE1PATH_STRING);
				table1filepath = sc.nextLine().trim();
				t1 = new Table(table1filepath);
				t1.load();
				
				System.out.println(TABLE2PATH_STRING);
				table2filepath = sc.nextLine().trim();
				t2 = new Table(table2filepath);
				t2.load();
				
				break;
			} catch (Exception e) {
				System.out.println("Load file error. please input correct file path" +
						" or check the content of each file.");
			}
		}
		

		System.out.println(COMMAND_DETAIL_STRING);
		Table temp = new Table();
		
		while (true) {
			try {
				System.out.print(COMMAND_STRING);
				String command = sc.nextLine().trim();
				String s = command.substring(0, 1).toUpperCase();
				if(s.equals("C")){
					temp = CartesianProduct(t1, t2);
				} else if(s.equals("N")){
					temp = NaturalJoin(t1, t2);
				} else if(s.equals("L")){
					temp = LeftOuterJoin(t1, t2);
				} else if(s.equals("P")){
					temp.print();
				} else if(s.equals("S")){
					temp.filePath = command.split(" ")[1].trim();
					temp.save();
				} else if(s.equals("E")){
					break;
				} else {
					System.out.println("The command is incorrect.");
				}
			} catch (Exception e) {
				System.out.println("Command error. please check your command.");
			}
		}
	}

	/**
	 * Return a Cartesian product of two tables.
	 * @param t1
	 * @param t2
	 * @return A new result table. 
	 */
	public Table CartesianProduct(Table t1, Table t2) {
		Table result = new Table();
		
		result.attributes.addAll(t1.attributes);
		result.attributes.addAll(t2.attributes);
		
		for(Tuple tp1 : t1.tuples){
			for(Tuple tp2 : t2.tuples){
				Tuple t = new Tuple();
				t.values.addAll(tp1.values);
				t.values.addAll(tp2.values);
				result.tuples.add(t);
			}
		}
		return result;
	}

	/**
	 * Return a natural join of two tables.
	 * @param t1
	 * @param t2
	 * @return A new result table. 
	 */
	public Table NaturalJoin(Table t1, Table t2) {
		Table result = new Table();
		ArrayList<String> sameAttrList = new ArrayList<String>();
		
		//find out the same attributes
		result.attributes.addAll(t1.attributes);
		for(String s2 : t2.attributes){
			if(t1.attributes.contains(s2)){
				sameAttrList.add(s2);
			} else {
				result.attributes.add(s2);
			}
		}
		
		for(Tuple tp1 : t1.tuples){
			for(Tuple tp2 : t2.tuples){
				boolean isMatch = true;
				for(String sameAttr : sameAttrList){
					String value1 = tp1.values.get(t1.attributes.indexOf(sameAttr));
					String value2 = tp2.values.get(t2.attributes.indexOf(sameAttr));
					if(!value1.equals(value2)){
						isMatch = false;
						break;
					}
				}
				
				if(isMatch){
					Tuple t = new Tuple();
					t.values.addAll(tp1.values);
					for(int i=0; i < tp2.values.size(); i++){
						boolean isDuplicatedValue = false;
						for(String sameAttr : sameAttrList){
							if(i == t2.attributes.indexOf(sameAttr)){
								isDuplicatedValue = true;
								break;
							}

						}
						if(!isDuplicatedValue){
							t.values.add(tp2.values.get(i));
						}
					}
					result.tuples.add(t);
				}
			}
		}
		
		return result;
	}
	
	/**
	 * Return a left outer join of two tables.
	 * @param t1
	 * @param t2
	 * @return A new result table. 
	 */
	public Table LeftOuterJoin(Table t1, Table t2) {
		Table result = new Table();
		ArrayList<String> sameAttrList = new ArrayList<String>();
		
		//Copy all attributes in t1.
		result.attributes.addAll(t1.attributes);
		for(String s2 : t2.attributes){
			if(t1.attributes.contains(s2)){
				sameAttrList.add(s2);
			} else {
				result.attributes.add(s2);
			}
		}
		
		//Find out the same attributes in t2. Actually, there should be an "ON" condition in SQL command, but I faked
		//This command, use natural join as the "ON" condition, but the result is different than natural join.
		for(Tuple tp1 : t1.tuples){
			Tuple t = new Tuple();
			t.values.addAll(tp1.values);
			
			boolean isNull = true;
			
			for(Tuple tp2 : t2.tuples){
				boolean isMatch = true;
				for(String sameAttr : sameAttrList){
					String value1 = tp1.values.get(t1.attributes.indexOf(sameAttr));
					String value2 = tp2.values.get(t2.attributes.indexOf(sameAttr));
					if(!value1.equals(value2)){
						isMatch = false;
						break;
					}
				}
				
				if(isMatch){
					for(int i=0; i < tp2.values.size(); i++){
						boolean isDuplicatedValue = false;
						for(String sameAttr : sameAttrList){
							if(i == t2.attributes.indexOf(sameAttr)){
								isDuplicatedValue = true;
								break;
							}

						}
						if(!isDuplicatedValue){
							t.values.add(tp2.values.get(i));
						}
					}
					
					isNull = false;
					break;
				}
			}
			
			if(isNull){
				for(int i=0; i<t2.attributes.size() - sameAttrList.size(); i++){
					t.values.add("NULL");
				}
			}
			
			result.tuples.add(t);
		}
		
		return result;
	}
	
	/**
	 * Transfer from String[] to ArrayList<String>
	 * @param str
	 * @return
	 */
	public static ArrayList<String> toArrayList(String[] str){
		ArrayList<String> list = new ArrayList<String>();
		for(String s : str){
			list.add(s);
		}
		
		return list;
	}

	/**
	 * This is a Tuple.
	 */
	class Tuple {
		ArrayList<String> values;

		public Tuple() {
			this.values = new ArrayList<String>();
		}

		public Tuple(String s) {
			this.values = toArrayList(s.split(SEPARATOR));
		}
	}

	/**
	 * This is a table entity, include tuples, attributes and file path. 
	 */
	class Table {
		ArrayList<Tuple> tuples;
		ArrayList<String> attributes;
		String filePath;

		public Table() {
			this.tuples = new ArrayList<Tuple>();
			this.attributes = new ArrayList<String>();
		}

		public Table(String filePath) {
			this();
		
			this.filePath = filePath;
		}

		public void load() throws IOException {
			InputStream is;
			is = new FileInputStream(filePath);
			Scanner sc = new Scanner(is);

			// Load attributes name(the name of each column, actually, the attributes should stored in sys_table)
			if (sc.hasNext()) {
				this.attributes = toArrayList(sc.nextLine().trim().split(SEPARATOR));

				// Load data.(the data should have the same length of
				// attributes)
				while (sc.hasNext()) {
					Tuple t = new Tuple(sc.nextLine().trim());
					if (t.values.size() == this.attributes.size()) {
						this.tuples.add(t);
					}
				}
			}

			sc.close();
			is.close();
		}

		public void save()  throws IOException  {
			FileOutputStream fs;
			BufferedWriter bw = new BufferedWriter(new FileWriter(this.filePath));
			
			//Write attributes
			for (int i = 0; i < this.attributes.size(); i++) {
				bw.write(this.attributes.get(i) + SEPARATOR);
			}
			bw.newLine();
			
			//Write tuples
			for (Tuple t : this.tuples) {
				for (int i = 0; i < t.values.size(); i++) {
					bw.write(t.values.get(i).toString() + SEPARATOR);
				}
				bw.newLine();
			}
			
			bw.close();
		}

		public void print() {
			System.out.print("\n[Filepath]:");
			System.out.print(this.filePath);

			System.out.print("\n[Attributes]:");	//Write attributes
			for (int i = 0; i < this.attributes.size(); i++) {
				System.out.print(this.attributes.get(i) + SEPARATOR);
			}

			System.out.println("\n[Tuples]:");		//Write tuples
			for (Tuple t : this.tuples) {
				for (int i = 0; i < t.values.size(); i++) {
					System.out.print(t.values.get(i).toString() + SEPARATOR);
				}
				System.out.println();
			}
		}
	}
}
