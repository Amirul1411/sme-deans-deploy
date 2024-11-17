import os
import logging
from datetime import datetime, timedelta
import smtplib
from email.mime.text import MIMEText

logging.basicConfig(
    filename='/backups/monitor.log',
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)

def check_backups():
    backup_dir = "/backups"
    
    # Check if backup directory exists
    if not os.path.exists(backup_dir):
        logging.error("Backup directory does not exist")
        return False
        
    # Get list of backup files
    backups = [f for f in os.listdir(backup_dir) if f.endswith('.sql.gz')]
    
    if not backups:
        logging.error("No backups found")
        return False
        
    # Check latest backup
    latest_backup = max(backups)
    backup_path = os.path.join(backup_dir, latest_backup)
    backup_time = datetime.fromtimestamp(os.path.getmtime(backup_path))
    
    # Alert if backup is older than 24 hours
    if datetime.now() - backup_time > timedelta(hours=24):
        logging.error(f"Latest backup is too old: {latest_backup}")
        return False
        
    logging.info(f"Backup check passed. Latest backup: {latest_backup}")
    return True

if __name__ == "__main__":
    check_backups() 