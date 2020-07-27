package view;

import java.awt.BorderLayout;
import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.table.DefaultTableModel;

import dao.DAOReservation;
import entity.LendingHistory;
import entity.Reservation;

import javax.swing.JLabel;
import java.awt.Window.Type;
import javax.swing.JTextField;
import javax.swing.GroupLayout;
import javax.swing.GroupLayout.Alignment;
import javax.swing.SwingConstants;
import javax.swing.LayoutStyle.ComponentPlacement;
import javax.swing.JComboBox;
import javax.swing.JButton;
import javax.swing.JTextArea;
import javax.swing.JTabbedPane;
import javax.swing.JToolBar;
import javax.swing.JDesktopPane;
import javax.swing.JLayeredPane;
import javax.swing.JOptionPane;
import javax.swing.JInternalFrame;
import java.awt.Font;
import java.awt.event.ActionListener;
import java.util.Date;
import java.awt.event.ActionEvent;
import javax.swing.JScrollPane;
import javax.swing.JTable;

public class bookRequest extends JFrame {

	private JPanel contentPane;
	private JTextField keyword;
	private JButton btnLoadRequest;
	private JScrollPane scrollPane;
	private JTable table;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					bookRequest frame = new bookRequest();
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
	public bookRequest() {
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 766, 596);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		
		JLabel lblBookRequest = new JLabel("Book Request");
		lblBookRequest.setFont(new Font("Dialog", Font.BOLD, 20));
		lblBookRequest.setHorizontalAlignment(SwingConstants.CENTER);
		
		keyword = new JTextField();
		keyword.setColumns(10);
		
		JLabel lblSearch = new JLabel("Search");
		lblSearch.setFont(new Font("Dialog", Font.BOLD, 16));
		
		JButton btnAccept = new JButton("Accept");
		btnAccept.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				btnAcceptActionPerformed(arg0);
			}
		});
		
		JButton btnDenied = new JButton("Denied");
		btnDenied.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				btnDeniedActionPerformed(arg0);
			}
		});
		
		btnLoadRequest = new JButton("Load Request");
		btnLoadRequest.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				btnLoadRequestActionPerformed(arg0);
			}
		});
		
		scrollPane = new JScrollPane();
		GroupLayout gl_contentPane = new GroupLayout(contentPane);
		gl_contentPane.setHorizontalGroup(
			gl_contentPane.createParallelGroup(Alignment.TRAILING)
				.addGroup(gl_contentPane.createSequentialGroup()
					.addGroup(gl_contentPane.createParallelGroup(Alignment.LEADING)
						.addGroup(gl_contentPane.createSequentialGroup()
							.addGap(111)
							.addComponent(btnAccept)
							.addGap(56)
							.addComponent(btnDenied))
						.addGroup(gl_contentPane.createSequentialGroup()
							.addGap(25)
							.addComponent(lblSearch)
							.addPreferredGap(ComponentPlacement.UNRELATED)
							.addComponent(keyword, GroupLayout.PREFERRED_SIZE, 198, GroupLayout.PREFERRED_SIZE)
							.addGap(28)
							.addComponent(btnLoadRequest, GroupLayout.PREFERRED_SIZE, 168, GroupLayout.PREFERRED_SIZE)))
					.addContainerGap(13, Short.MAX_VALUE))
				.addGroup(gl_contentPane.createSequentialGroup()
					.addContainerGap(257, Short.MAX_VALUE)
					.addComponent(lblBookRequest, GroupLayout.PREFERRED_SIZE, 260, GroupLayout.PREFERRED_SIZE)
					.addGap(239))
				.addGroup(Alignment.LEADING, gl_contentPane.createSequentialGroup()
					.addContainerGap()
					.addComponent(scrollPane, GroupLayout.PREFERRED_SIZE, 735, GroupLayout.PREFERRED_SIZE)
					.addContainerGap(GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
		);
		gl_contentPane.setVerticalGroup(
			gl_contentPane.createParallelGroup(Alignment.LEADING)
				.addGroup(gl_contentPane.createSequentialGroup()
					.addContainerGap()
					.addComponent(lblBookRequest, GroupLayout.PREFERRED_SIZE, 38, GroupLayout.PREFERRED_SIZE)
					.addGap(52)
					.addGroup(gl_contentPane.createParallelGroup(Alignment.BASELINE)
						.addComponent(lblSearch)
						.addComponent(keyword, GroupLayout.PREFERRED_SIZE, 34, GroupLayout.PREFERRED_SIZE)
						.addComponent(btnLoadRequest, GroupLayout.PREFERRED_SIZE, 34, GroupLayout.PREFERRED_SIZE))
					.addGap(47)
					.addComponent(scrollPane, GroupLayout.PREFERRED_SIZE, 228, GroupLayout.PREFERRED_SIZE)
					.addPreferredGap(ComponentPlacement.RELATED, 59, Short.MAX_VALUE)
					.addGroup(gl_contentPane.createParallelGroup(Alignment.BASELINE)
						.addComponent(btnAccept)
						.addComponent(btnDenied))
					.addGap(53))
		);
		
		table = new JTable();
		scrollPane.setViewportView(table);
		contentPane.setLayout(gl_contentPane);
	}
	protected void btnLoadRequestActionPerformed(ActionEvent arg0) {
		Load();
	}
	private void Load() {
		DefaultTableModel model = new DefaultTableModel();
		model.addColumn("ReserveNo");
		model.addColumn("LibraryID");
		model.addColumn("BookID");	
		model.addColumn("DReserve");
		model.addColumn("Status");

	String status = null;
	for(Reservation re : DAOReservation.Load()) {
		if (re.getStatus() == true) {
			status = "pending";
			}else {
				status = "done";
			}
		model.addRow( new Object[] {
				re.getReserveNo(),
				DAOReservation.getLibraryID(re.getAccountNO()),
				DAOReservation.getBookID(re.getBookID()),
				re.getDReserve(),
				status,
			});
		}
	
		table.setModel(model);
	}
	protected void btnDeniedActionPerformed(ActionEvent arg0) {
		String value = table.getValueAt(table.getSelectedRow(), 0).toString();
		int id = Integer.parseInt(value);
		DAOReservation.DeleteRequest(id);
		Load();
	}
	
	protected void btnAcceptActionPerformed(ActionEvent arg0) {
		String value = table.getValueAt(table.getSelectedRow(), 0).toString().trim();
		int id = Integer.parseInt(value);
		
		for(Reservation res : DAOReservation.getReservationInfo(id)) {
			int resNo = id;
			int accNo = res.getAccountNO();
			int bookID = res.getBookID();
			JOptionPane.showMessageDialog(null, id);
			DAOReservation.InsertLending(resNo, accNo, bookID);
			}
		Load();
	}
}

