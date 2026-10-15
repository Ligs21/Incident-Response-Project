# Incident Response Investigation Project

## About the Project

This project was created as part of my cybersecurity learning to understand how incident response investigations are carried out in a real-world environment. I used an Ubuntu virtual machine in VirtualBox to practice analyzing system logs, investigating login activity, checking network connections, and documenting my findings.

The main goal was to understand how a security analyst investigates unusual activity and uses available evidence to assess whether a system may be at risk.

## What I Worked On

During this project, I worked on the following tasks:

- Analyzed authentication logs to review successful and failed login attempts.
- Checked for repeated SSH login failures and identified the IP addresses involved.
- Reviewed system logs to understand recorded system activity.
- Examined network connections to look for potentially suspicious communication.
- Checked running processes as part of the system investigation.
- Created a timeline of relevant events.
- Organized the collected information and prepared an incident response report.

## Tools and Environment

- **Operating System:** Ubuntu Linux
- **Virtualization:** Oracle VirtualBox
- **Log Analysis:** Linux commands such as `grep`, `cat`, and `journalctl`
- **Network Analysis:** `ss`
- **Process Analysis:** `ps`
- **Documentation:** Markdown and PDF

## Project Structure

- `logs/` – Contains authentication and system log analysis files.
- `network_analysis/` – Contains the results of network connection checks.
- `indicators/` – Contains recorded indicators, IP addresses, and analysis notes.
- `reports/` – Contains the incident response report in PDF and Markdown formats.
- `screenshots/` – Contains screenshots taken during the investigation.
- `timeline.txt` – Records relevant events from the investigation.

## Investigation Findings

I reviewed authentication records, including failed and accepted login attempts, and examined IP addresses associated with repeated failures. I also checked system logs, running processes, and active network connections.

The results of these checks are documented in the project files and final report. Network connections were investigated based on the available evidence, and no clearly suspicious connection was confirmed in the earlier assessment. This conclusion applies only to the connections examined during the investigation.

## What I Learned

Working on this project helped me gain practical experience with Linux command-line tools, authentication log analysis, network inspection, and incident documentation. It also helped me understand the importance of preserving evidence and making conclusions based on actual findings rather than assumptions.

## Conclusion

This project gave me an opportunity to apply the cybersecurity concepts I have been learning in a controlled virtual lab. It helped me understand the basic workflow of an incident response investigation, from examining logs to documenting findings and preparing a final report.

## Disclaimer

This project is intended for educational purposes and was conducted in a virtual lab environment. The findings are limited to the evidence collected and analyzed during the investigation.
