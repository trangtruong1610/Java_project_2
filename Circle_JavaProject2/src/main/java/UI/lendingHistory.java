package UI;

import java.awt.BorderLayout;
import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.table.DefaultTableModel;

import dao.DAOLendingHistory;
import dao.DAOReservation;
import entity.LendingHistory;
import entity.Reservation;

import javax.swing.GroupLayout;
import javax.swing.GroupLayout.Alignment;
import javax.swing.JScrollPane;
import javax.swing.JTabbedPane;
import javax.swing.JTable;
import javax.swing.JButton;
import javax.swing.LayoutStyle.ComponentPlacement;
import java.awt.event.ActionListener;
import java.sql.Date;
import java.util.Calendar;
import java.awt.event.ActionEvent;

public class lendingHistory extends JFrame {

	private JPanel contentPane;
	private JScrollPane scrollPane;
	private JTable table;
	private JButton btnLoadLendingHistory;
	private JButton btnReturn;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					lendingHistory frame = new lendingHistory();
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
	public lendingHistory() {
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 832, 685);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		
		scrollPane = new JScrollPane();
		
		btnLoadLendingHistory = new JButton("Load Lending History");
		btnLoadLendingHistory.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				btnLoadLendingHistoryActionPerformed(arg0);
			}
		});
		
		btnReturn = new JButton("Return");
		btnReturn.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				btnReturnActionPerformed(arg0);
			}
		});
		GroupLayout gl_contentPane = new GroupLayout(contentPane);
		gl_contentPane.setHorizontalGroup(
			gl_contentPane.createParallelGroup(Alignment.TRAILING)
				.addGroup(gl_contentPane.createSequentialGroup()
					.addContainerGap()
					.addComponent(scrollPane, GroupLayout.PREFERRED_SIZE, 802, GroupLayout.PREFERRED_SIZE)
					.addContainerGap(GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
				.addGroup(gl_contentPane.createSequentialGroup()
					.addContainerGap(332, Short.MAX_VALUE)
					.addComponent(btnLoadLendingHistory)
					.addGap(309))
				.addGroup(gl_contentPane.createSequentialGroup()
					.addContainerGap(358, Short.MAX_VALUE)
					.addComponent(btnReturn)
					.addGap(347))
		);
		gl_contentPane.setVerticalGroup(
			gl_contentPane.createParallelGroup(Alignment.TRAILING)
				.addGroup(gl_contentPane.createSequentialGroup()
					.addGap(40)
					.addComponent(btnLoadLendingHistory)
					.addPreferredGap(ComponentPlacement.RELATED, 64, Short.MAX_VALUE)
					.addComponent(scrollPane, GroupLayout.PREFERRED_SIZE, 402, GroupLayout.PREFERRED_SIZE)
					.addGap(35)
					.addComponent(btnReturn)
					.addGap(47))
		);
		
		table = new JTable();
		scrollPane.setViewportView(table);
		contentPane.setLayout(gl_contentPane);
	}
	protected void btnLoadLendingHistoryActionPerformed(ActionEvent arg0) {
		Load();
	}

	private void Load() {
		DefaultTableModel model = new DefaultTableModel();
		model.addColumn("LenNo");
		model.addColumn("ReserveNo");
		model.addColumn("AccountNo");	
		model.addColumn("ItemNo");
		model.addColumn("DIssued");
		model.addColumn("DReturned");
		model.addColumn("Status");
		
		String status = null;
		for(LendingHistory le : DAOLendingHistory.Load()) {
			if (le.getStatus() == true) {
				status = "lending";
				}else {
					status = "return";
				}

			model.addRow( new Object[] {
					le.getLendNo(),
					le.getReserveNo(),
					le.getAccountNo(),
					le.getItemNo(),
					le.getDIssued(),
					le.getDReturned(),
					status,
					
				});
			}
		
			table.setModel(model);

	}
	protected void btnReturnActionPerformed(ActionEvent arg0) {
		String value = table.getValueAt(table.getSelectedRow(), 0).toString();
		int id = Integer.parseInt(value);
		Calendar calendar = Calendar.getInstance();
	    java.sql.Date d = new java.sql.Date(calendar.getTime().getTime());
	    DAOLendingHistory.ReturnLending(id, d);
	    Load();
	}
}
