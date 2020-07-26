package UI;

import java.awt.BorderLayout;
import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.border.MatteBorder;
import java.awt.Color;
import javax.swing.JLabel;
import javax.swing.JOptionPane;

import java.awt.Font;
import javax.swing.SwingConstants;
import javax.swing.JTextField;
import com.toedter.calendar.JDateChooser;

import common.ConnecToProperties;
import entity.Account;

import javax.swing.JComboBox;
import javax.swing.JButton;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableModel;
import javax.swing.DefaultComboBoxModel;
import javax.swing.ImageIcon;

import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import javax.swing.JPasswordField;
import java.awt.event.FocusAdapter;
import java.awt.event.FocusEvent;

public class AccountManagement extends JFrame {

	private JPanel contentPane;
	private JFrame frame;
	private JTextField username;
	private JTextField id;
	private JTextField point;
	private JTable tableAccount;
	private boolean isAdmin = false;
	private JTextField no;
	private JTextField searchdata;
	private JPasswordField password;
	private JLabel id_validation;
	private JLabel user_validation;
	private JLabel pass_validation;
	private String txtName, txtId, txtPass, txtNo;
	
	public ArrayList<Account> accountsList(){
		ArrayList<Account> accountsList = new ArrayList<>();
		try (
				var connection = DriverManager.getConnection(ConnecToProperties.getConnectionUrl());
		) {
			String query = "SELECT * FROM Account";
			Statement st = connection.createStatement();
			ResultSet rs = st.executeQuery(query);
			Account account;
			
			while(rs.next()) {
				account = new Account(rs.getInt("AccountNo"), rs.getString("AccountName"), rs.getString("LibraryID"), rs.getString("Password"), rs.getBoolean("IsAdmin"), rs.getString("DJoined"),rs.getString("DExpired"),rs.getInt("Points"),rs.getBoolean("Status"));
				accountsList.add(account);
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		return accountsList;
	}
	
	public void show_account() {
		ArrayList<Account> list = accountsList();
		DefaultTableModel model = (DefaultTableModel)tableAccount.getModel();
		Object[] row = new Object[7];
		for(int i=0; i<list.size(); i++) {
			row[0] = list.get(i).getAccountNo();
			row[1] = list.get(i).getAccountName();
			row[2] = list.get(i).getLibraryID();
			row[3] = list.get(i).getDJoined();
			row[4] = list.get(i).getDExpired();
			row[5] = list.get(i).getPoint();
			String status = "Enable";
			if (list.get(i).getStatus().equals(false)) {
				status = "Disable";
			}
			row[6] = status;
			model.addRow(row);
		}
	}

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					AccountManagement frame = new AccountManagement();
					frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	/**
	 * Create the frame.
	 */
	public AccountManagement() {
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(320, 180, 1200, 750);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		JPanel panel = new JPanel();
		panel.setBackground(new Color(220, 220, 220));
		panel.setBorder(new MatteBorder(2, 2, 2, 2, (Color) new Color(128, 128, 128)));
		panel.setBounds(0, 0, 1188, 730);
		contentPane.add(panel);
		panel.setLayout(null);
		
		JPanel panel_1 = new JPanel();
		panel_1.setLayout(null);
		panel_1.setBorder(new MatteBorder(2, 2, 2, 2, (Color) new Color(128, 128, 128)));
		panel_1.setBackground(new Color(220, 220, 220));
		panel_1.setBounds(10, 10, 1165, 31);
		panel.add(panel_1);
		
		JLabel lblNewLabel = new JLabel("LIBRARY SYSTEM");
		lblNewLabel.setHorizontalAlignment(SwingConstants.CENTER);
		lblNewLabel.setForeground(new Color(255, 255, 255));
		lblNewLabel.setFont(new Font("Tahoma", Font.BOLD, 20));
		lblNewLabel.setBounds(0, 0, 880, 31);
		panel_1.add(lblNewLabel);
		
		JPanel panel_1_1 = new JPanel();
		panel_1_1.setLayout(null);
		panel_1_1.setBorder(new MatteBorder(2, 2, 2, 2, (Color) new Color(128, 128, 128)));
		panel_1_1.setBackground(new Color(220, 220, 220));
		panel_1_1.setBounds(10, 35, 250, 610);
		panel.add(panel_1_1);
		
		JLabel lblNewLabel_1 = new JLabel("Username");
		lblNewLabel_1.setFont(new Font("Tahoma", Font.BOLD, 12));
		lblNewLabel_1.setForeground(new Color(255, 255, 255));
		lblNewLabel_1.setBounds(10, 105, 100, 15);
		panel_1_1.add(lblNewLabel_1);
		
		JLabel lblNewLabel_1_1 = new JLabel("Library ID");
		lblNewLabel_1_1.setFont(new Font("Tahoma", Font.BOLD, 12));
		lblNewLabel_1_1.setForeground(new Color(255, 255, 255));
		lblNewLabel_1_1.setBounds(10, 170, 100, 15);
		panel_1_1.add(lblNewLabel_1_1);
		
		JLabel lblNewLabel_1_2 = new JLabel("Password");
		lblNewLabel_1_2.setFont(new Font("Tahoma", Font.BOLD, 12));
		lblNewLabel_1_2.setForeground(new Color(255, 255, 255));
		lblNewLabel_1_2.setBounds(10, 235, 100, 15);
		panel_1_1.add(lblNewLabel_1_2);
		
		JLabel lblNewLabel_1_3 = new JLabel("Joining Date");
		lblNewLabel_1_3.setFont(new Font("Tahoma", Font.BOLD, 12));
		lblNewLabel_1_3.setForeground(new Color(255, 255, 255));
		lblNewLabel_1_3.setBounds(10, 304, 100, 15);
		panel_1_1.add(lblNewLabel_1_3);
		
		JLabel lblNewLabel_1_5 = new JLabel("Point");
		lblNewLabel_1_5.setFont(new Font("Tahoma", Font.BOLD, 12));
		lblNewLabel_1_5.setForeground(new Color(255, 255, 255));
		lblNewLabel_1_5.setBounds(10, 435, 100, 15);
		panel_1_1.add(lblNewLabel_1_5);
		
		JLabel lblNewLabel_1_6 = new JLabel("Status");
		lblNewLabel_1_6.setFont(new Font("Tahoma", Font.BOLD, 12));
		lblNewLabel_1_6.setForeground(new Color(255, 255, 255));
		lblNewLabel_1_6.setBounds(10, 505, 100, 15);
		panel_1_1.add(lblNewLabel_1_6);
		
		username = new JTextField();
		username.addFocusListener(new FocusAdapter() {
			@Override
			public void focusLost(FocusEvent e) {
				try (
						Connection connection = DriverManager.getConnection(ConnecToProperties.getConnectionUrl());
				) {
					String queryAcc = "SELECT * From Account where AccountName=?";
					PreparedStatement pstAcc = connection.prepareStatement(queryAcc);
					pstAcc.setString(1, username.getText());
					ResultSet rsAcc = pstAcc.executeQuery();
					
					if(rsAcc.next()) {
						user_validation.setText("Username already exists");
						user_validation.setForeground(Color.cyan);
						} else {
							String USER_PATTERN = "Student\\d{3,10}";
							Pattern patternUser = Pattern.compile(USER_PATTERN);
							Matcher matcherUser = patternUser.matcher(username.getText()); 
							if(matcherUser.matches()) {
								user_validation.setText("");
								txtName = username.getText();
							}else {
								user_validation.setForeground(Color.red);
								user_validation.setText("Account Name must start with Student*****");
							}
						}
					} catch (SQLException err) {
					System.out.println(err.getMessage());
				}
			}
		});
		username.setBounds(10, 120, 215, 20);
		panel_1_1.add(username);
		username.setColumns(10);
		
		id = new JTextField();
		id.addFocusListener(new FocusAdapter() {
			@Override
			public void focusLost(FocusEvent e) {
				try (
						var connection = DriverManager.getConnection(ConnecToProperties.getConnectionUrl());
				) {
					String queryDB = "SELECT * From Account where LibraryID=?";
					PreparedStatement pstDB = connection.prepareStatement(queryDB);
					pstDB.setString(1, id.getText());
					ResultSet rs = pstDB.executeQuery();
					
					if(rs.next()) {
						id_validation.setText("Library ID already exists");
						id_validation.setForeground(Color.cyan);
						} else {
							String ID_PATTERN = "\\d{6}[-][A-Z]\\d{4}";
							Pattern pattern = Pattern.compile(ID_PATTERN);
							Matcher matcher = pattern.matcher(id.getText()); 
							if(matcher.matches()) {
								id_validation.setText("");
								txtId = id.getText();
							}else {
								id_validation.setForeground(Color.red);
								id_validation.setText("Library ID must start with 000000-A0000");
							}
						}
					} catch (SQLException err) {
					System.out.println(err.getMessage());
				}
			}
		});
		id.setColumns(10);
		id.setBounds(10, 185, 215, 20);
		panel_1_1.add(id);
		
		point = new JTextField();
		point.setText("100");
		point.setColumns(10);
		point.setBounds(10, 450, 215, 20);
		panel_1_1.add(point);
		
		JDateChooser joiningDateChooser = new JDateChooser();
		joiningDateChooser.setDate(java.sql.Date.valueOf(java.time.LocalDate.now())); 
		joiningDateChooser.setBounds(10, 320, 215, 20);
		panel_1_1.add(joiningDateChooser);
		
		JDateChooser expiryDateChooser = new JDateChooser();
		expiryDateChooser.setDate(java.sql.Date.valueOf(java.time.LocalDate.now())); 
		expiryDateChooser.setBounds(10, 385, 215, 20);
		panel_1_1.add(expiryDateChooser);
		
		JComboBox status = new JComboBox();
		status.setModel(new DefaultComboBoxModel(new String[] {"Enable", "Disable"}));
		status.setBounds(10, 520, 215, 22);
		panel_1_1.add(status);
		
		JLabel lblSearch = new JLabel("");
		lblSearch.setForeground(new Color(255, 255, 255));
		lblSearch.setFont(new Font("Tahoma", Font.BOLD, 15));
		lblSearch.setIcon(new ImageIcon(LoginForm.class.getResource("/search.png")));
		lblSearch.setBounds(215, 10, 35, 30);
		panel_1_1.add(lblSearch);
		
		no = new JTextField();
		no.setEnabled(false);
		no.setColumns(10);
		no.setBounds(10, 55, 215, 20);
		panel_1_1.add(no);
		
		searchdata = new JTextField();
		searchdata.addKeyListener(new KeyAdapter() {
			@Override
			public void keyReleased(KeyEvent e) {
				try (
						Connection connection = DriverManager.getConnection(ConnecToProperties.getConnectionUrl());
				) {
					String sql = "Select * from Account where LibraryID = ?";
					PreparedStatement pst = connection.prepareStatement(sql);
					pst.setString(1, searchdata.getText());
					ResultSet rs = pst.executeQuery();
					if(rs.next()) {
						String setNo = String.valueOf(rs.getInt("AccountNo"));
						no.setText(setNo);
						
						String setUsername = rs.getString("AccountName");
						username.setText(setUsername);
						username.setEnabled(false);
						
						String setId = rs.getString("LibraryID");
						id.setText(setId);
						id.setEnabled(false);
						
						String setPassword = rs.getString("Password");
						password.setText(setPassword);
						password.setEnabled(false);
						
						joiningDateChooser.setDate(rs.getDate("DJoined"));
						expiryDateChooser.setDate(rs.getDate("DExpired"));
						
						String setPoint = rs.getString("Points");
						point.setText(setPoint);
						
						boolean _status = rs.getBoolean("Status");
						status.setSelectedIndex(1);
						if(_status) {
							status.setSelectedIndex(0);
						}
					}
				} catch (SQLException error) {
					System.out.println(error.getMessage());
				}
			}
		});
		searchdata.setColumns(10);
		searchdata.setBounds(10, 15, 195, 20);
		panel_1_1.add(searchdata);
		
		JLabel lblNewLabel_1_7 = new JLabel("No");
		lblNewLabel_1_7.setForeground(Color.WHITE);
		lblNewLabel_1_7.setFont(new Font("Tahoma", Font.BOLD, 12));
		lblNewLabel_1_7.setBounds(10, 37, 100, 15);
		panel_1_1.add(lblNewLabel_1_7);
		
		password = new JPasswordField();
		password.addFocusListener(new FocusAdapter() {
			@Override
			public void focusLost(FocusEvent e) {
				if(password.getText().length() < 8 || password.getText().length() > 20) {
					pass_validation.setText("Password must be 8 to 20 character");
				}else {
					pass_validation.setText("");
					txtPass = password.getText();
				}
			}
		});
		password.setBounds(10, 250, 215, 20);
		panel_1_1.add(password);
		
		JLabel lblNewLabel_1_4 = new JLabel("Expiry Date");
		lblNewLabel_1_4.setBounds(10, 370, 215, 15);
		panel_1_1.add(lblNewLabel_1_4);
		lblNewLabel_1_4.setFont(new Font("Tahoma", Font.BOLD, 12));
		lblNewLabel_1_4.setForeground(new Color(255, 255, 255));
		
		user_validation = new JLabel("");
		user_validation.setFont(new Font("Tahoma", Font.BOLD, 9));
		user_validation.setForeground(new Color(255, 0, 0));
		user_validation.setBounds(10, 145, 215, 14);
		panel_1_1.add(user_validation);
		
		id_validation = new JLabel("");
		id_validation.setFont(new Font("Tahoma", Font.BOLD, 9));
		id_validation.setForeground(new Color(255, 0, 0));
		id_validation.setBounds(10, 210, 215, 14);
		panel_1_1.add(id_validation);
		
		pass_validation = new JLabel("");
		pass_validation.setFont(new Font("Tahoma", Font.BOLD, 9));
		pass_validation.setForeground(new Color(255, 0, 0));
		pass_validation.setBounds(10, 275, 215, 14);
		panel_1_1.add(pass_validation);
		
		JPanel panel_1_1_1 = new JPanel();
		panel_1_1_1.setLayout(null);
		panel_1_1_1.setBorder(new MatteBorder(2, 2, 2, 2, (Color) new Color(128, 128, 128)));
		panel_1_1_1.setBackground(new Color(220, 220, 220));
		panel_1_1_1.setBounds(259, 39, 916, 606);
		panel.add(panel_1_1_1);
		
		JScrollPane scrollPane = new JScrollPane();
		scrollPane.setBounds(10, 11, 896, 572);
		panel_1_1_1.add(scrollPane);
		
		tableAccount = new JTable();
		tableAccount.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				user_validation.setText("");
				id_validation.setText("");
				pass_validation.setText("");
				
				int index = tableAccount.getSelectedRow();
				TableModel model = tableAccount.getModel();
				no.setText(model.getValueAt(index, 0).toString());
				no.setEnabled(false);
				username.setText(model.getValueAt(index, 1).toString());
				username.setEnabled(false);
				id.setText(model.getValueAt(index, 2).toString());
				id.setEnabled(false);
				
				password.setText(model.getValueAt(index, 3).toString());
				id.setEnabled(false);
				
				try {
					int srow = tableAccount.getSelectedRow();
					Date joiningDate = new SimpleDateFormat("yyyy-MM-dd").parse((String)model.getValueAt(srow, 3));
					joiningDateChooser.setDate(joiningDate);
					
					Date expiryDate = (Date)new SimpleDateFormat("yyyy-MM-dd").parse((String)model.getValueAt(srow, 4));
					expiryDateChooser.setDate(expiryDate);
				}catch(Exception err) {
					JOptionPane.showMessageDialog(null, err);
				}
				
				point.setText(model.getValueAt(index, 5).toString());
				
				String status_ = model.getValueAt(index, 6).toString();
				switch(status_) {
				case "Enable":
					status.setSelectedIndex(0);
					break;
				case "Disable":
					status.setSelectedIndex(1);
					break;
				}
				
				username.setText(model.getValueAt(index, 1).toString());
				username.setText(model.getValueAt(index, 1).toString());
			}
		});
		tableAccount.setModel(new DefaultTableModel(
			new Object[][] {
			},
			new String[] {
				"No", "Username", "Library ID", "Joining Date", "Expiry Date", "Point", "Status"
			}
		));
		scrollPane.setViewportView(tableAccount);
		
		JPanel panel_1_2 = new JPanel();
		panel_1_2.setLayout(null);
		panel_1_2.setBorder(new MatteBorder(2, 2, 2, 2, (Color) new Color(128, 128, 128)));
		panel_1_2.setBackground(new Color(220, 220, 220));
		panel_1_2.setBounds(10, 650, 1165, 50);
		panel.add(panel_1_2);
		
		JButton btnCreate = new JButton("CREATE");
		btnCreate.setBackground(new Color(0, 0, 255));
		btnCreate.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try (
						var connection = DriverManager.getConnection(ConnecToProperties.getConnectionUrl());
				) {
					if (txtName != null && txtId !=null && txtPass != null) {
						String query = "insert into Account(AccountName, LibraryID, Password, IsAdmin, DJoined, DExpired, Points, Status)values(?,?,?,?,?,?,?,?)";
						PreparedStatement pst = connection.prepareStatement(query);
						pst.setString(1, username.getText());
						pst.setString(2, id.getText());
						pst.setString(3, password.getText());
						pst.setBoolean(4, isAdmin);
						
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
						String joiningDate = sdf.format(joiningDateChooser.getDate());
						pst.setString(5, joiningDate);
						
						String expiryDate = sdf.format(expiryDateChooser.getDate());
						pst.setString(6, expiryDate);
						
						pst.setString(7, point.getText());
						
						String _status = status.getSelectedItem().toString();
						boolean status_ = false;
						if(_status.equals("Enable")) {
							status_ = true;
						}
						pst.setBoolean(8, status_);
						
						pst.executeUpdate();
						
						DefaultTableModel model = (DefaultTableModel)tableAccount.getModel();
						model.setRowCount(0);
						show_account();
						JOptionPane.showMessageDialog(null, "Account created successfully!");
						
						username.setText("");
						password.setText("");
						id.setText("");
						joiningDateChooser.setCalendar(null);
						expiryDateChooser.setCalendar(null);
						point.setText("");
						status.setSelectedIndex(0);
					}else {
						JOptionPane.showMessageDialog(null, "Please fill in the required fields");
					}
					
				} catch (SQLException err) {
					System.out.println(err.getMessage());
				}
				
			}
		});
		btnCreate.setForeground(new Color(255, 255, 255));
		
		btnCreate.setFont(new Font("Tahoma", Font.BOLD, 15));
		btnCreate.setBounds(100, 13, 120, 25);
		panel_1_2.add(btnCreate);
		
		JButton btnUpdate = new JButton("UPDATE");
		btnUpdate.setBackground(new Color(0, 128, 0));
		btnUpdate.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try (
						var connection = DriverManager.getConnection(ConnecToProperties.getConnectionUrl());
				) {
						String value = no.getText();
						txtName = username.getText();
						String query = "UPDATE Account SET Password=?, DExpired=?, Points=?, Status=? where AccountNo =" + value;
						PreparedStatement pst = connection.prepareStatement(query);
						
						pst.setString(1, password.getText());
						
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
						
						String expiryDate = sdf.format(expiryDateChooser.getDate());
						pst.setString(2, expiryDate);
						
						pst.setString(3, point.getText());
						
						String _status = status.getSelectedItem().toString();
						boolean status_ = false;
						if(_status.equals("Enable")) {
							status_ = true;
						}
						pst.setBoolean(4, status_);

						pst.executeUpdate();
						
						DefaultTableModel model = (DefaultTableModel)tableAccount.getModel();
						model.setRowCount(0);
						show_account();
						JOptionPane.showInternalMessageDialog(null, txtName + " Updated Successfully!");
						
						username.setText("");
						username.setEnabled(true);
						user_validation.setText("");
						password.setText("");
						password.setEnabled(true);
						pass_validation.setText("");
						id.setText("");
						id.setEnabled(true);
						id_validation.setText("");
						expiryDateChooser.setDate(java.sql.Date.valueOf(java.time.LocalDate.now())); 
						joiningDateChooser.setDate(java.sql.Date.valueOf(java.time.LocalDate.now())); 
						point.setText("");
						status.setSelectedIndex(0);
					
				} catch (SQLException error) {
					System.out.println(error.getMessage());
				}
			}
		});
		btnUpdate.setForeground(new Color(255, 255, 255));
		btnUpdate.setFont(new Font("Tahoma", Font.BOLD, 15));
		btnUpdate.setBounds(315, 13, 120, 23);
		panel_1_2.add(btnUpdate);
		
		JButton btnClear = new JButton("CLEAR");
		btnClear.setBackground(new Color(255, 165, 0));
		btnClear.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				username.setText("");
				username.setEnabled(true);
				user_validation.setText("");
				password.setText("");
				password.setEnabled(true);
				pass_validation.setText("");
				id.setText("");
				id.setEnabled(true);
				id_validation.setText("");
				expiryDateChooser.setDate(java.sql.Date.valueOf(java.time.LocalDate.now())); 
				joiningDateChooser.setDate(java.sql.Date.valueOf(java.time.LocalDate.now())); 
				point.setText("");
				status.setSelectedIndex(0);
			}
		});
		btnClear.setForeground(new Color(255, 255, 255));
		btnClear.setFont(new Font("Tahoma", Font.BOLD, 15));
		btnClear.setBounds(745, 13, 120, 25);
		panel_1_2.add(btnClear);
		
		JButton btnClose = new JButton("LOG OUT");
		btnClose.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				LoginForm field = new LoginForm();
				field.setVisible(true);
				setVisible(false);
			}
		});
		btnClose.setBackground(new Color(112, 128, 144));
		btnClose.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				dispose();
			}
		});
		btnClose.setForeground(new Color(255, 255, 255));
		btnClose.setFont(new Font("Tahoma", Font.BOLD, 15));
		btnClose.setBounds(950, 13, 120, 25);
		panel_1_2.add(btnClose);
		
		JButton btnDelete = new JButton("DELETE");
		btnDelete.setBackground(new Color(255, 0, 0));
		btnDelete.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				int opt = JOptionPane.showConfirmDialog(null,"Are You sure to Delete", "Delete", JOptionPane.YES_NO_OPTION);
				
				if(opt==0) {
					try (
							var connection = DriverManager.getConnection(ConnecToProperties.getConnectionUrl());
					) {
						txtName = username.getText();
						int row = tableAccount.getSelectedRow();
						String value = (tableAccount.getModel().getValueAt(row, 0).toString());
						String query = "DELETE FROM Account where AccountNo=" + value;
						PreparedStatement pst = connection.prepareStatement(query);
						pst.executeUpdate();
						
						DefaultTableModel model = (DefaultTableModel)tableAccount.getModel();
						model.setRowCount(0);
						
						show_account();
						JOptionPane.showMessageDialog(null, txtName + " Deleted Successfully!");
						
						username.setText("");
						password.setText("");
						id.setText("");
						joiningDateChooser.setCalendar(null);
						expiryDateChooser.setCalendar(null);
						point.setText("");
						status.setSelectedIndex(0);
						
					} catch (SQLException error) {
						System.out.println(error.getMessage());
					}
				}
			}
		});
		btnDelete.setForeground(Color.WHITE);
		btnDelete.setFont(new Font("Tahoma", Font.BOLD, 15));
		btnDelete.setBounds(530, 13, 120, 25);
		panel_1_2.add(btnDelete);
		
		show_account();
		
	}
}
