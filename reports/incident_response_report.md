# Incident Response Investigation Report

## 1. Incident Description
A simulated cybersecurity incident was conducted in an isolated lab environment to
practice SOC analyst investigation procedures.

- Target system: Ubuntu 24.04 LTS, IP 192.168.56.102 (user: ligs, sudo-privileged)
- Attacker/Monitoring system: Kali Linux, IP 192.168.56.103
- Incident type: Simulated SSH brute-force attack followed by unauthorized command
  execution and deployment of a persistent outbound beacon (reverse-connection style)
- Detection method: Real-time log monitoring (auth.log), network connection analysis
  (ss -tunap), and process monitoring (ps aux)

## 2. Evidence Collected
| File | Description |
|---|---|
| logs/failed_logins_confirmed.txt | SSH brute-force failed login entries |
| logs/accepted_logins.txt | Successful SSH login entries |
| logs/login_history.txt | Full login history (last -a) |
| network_analysis/suspicious_connections.txt | ss -tunap output showing active connections |
| network_analysis/capture.pcap | Packet capture of beacon traffic on port 4444 |
| indicators/.update.sh | Recovered malicious script |
| indicators/file_hash.txt | SHA-256 hash of malicious script |
| indicators/process_list.txt | Process snapshot showing malicious nc/.update.sh |
| indicators/analysis_summary.txt | Analyst notes and findings |

## 3. Indicators of Compromise (IoC)
| Type | Value | Source |
|---|---|---|
| Attacker/C2 IP | 192.168.56.103 | auth.log, ss -tunap |
| C2 port | 4444 | ss -tunap, pcap |
| Domain | None observed (direct IP-based C2, no DNS used) | N/A |
| Malicious file | /tmp/.update.sh | find, ps |
| File hash (SHA-256) | 950e6fb133397c8a49345418e51cb18bcecb73bc8833c811d156f0bc5c86ecb8 | sha256sum |
| Process | nc (child of .update.sh) | ps aux |
| Persistence | crontab @reboot entry | crontab -l |
| Targeted/compromised account | ligs (sudo-privileged) | auth.log |

## 4. Attack Timeline
| Time (+05:30) | Event |
|---|---|
| 2026-10-14 20:06:39 - 20:07:33 | Repeated failed SSH login attempts against 'ligs' from 192.168.56.103 (7 attempts, automated pattern) |
| [2026-10-14 20:09:48 (+05:30)] | Successful login to 'ligs' account |
| Unknown (not logged) | Reconnaissance commands executed: whoami, id, cat /etc/passwd |
| 2026-10-13 01:05:50 | Malicious script /tmp/.update.sh created |
| [2026-10-14 20:46:56 (IST, converted from EDT capture)] | Outbound beacon connection established to 192.168.56.103:4444 |
| [confirm if present] | removed during remediation |

**Note:** Exact timestamp for reconnaissance command execution could not be determined,
as auditd exec-level logging was not configured on the target at the time of the
incident. This was identified as a monitoring gap and addressed during remediation
(see Section 6).

## 5. Containment Actions
| Action | Status |
|---|---|
| Block malicious IP (ufw deny from 192.168.56.103) | Executed |
| Kill malicious processes (pkill -f /tmp/.update.sh, manual kill of residual nc PID) | Executed |
| Remove cron persistence (crontab -r) | Executed |
| Disable compromised account (usermod -L ligs) | Documented, not executed — account also served as investigator's access credential for this lab exercise |
| Isolate system from network (ip link down) | Documented, not executed — would have terminated the active investigation session; targeted IP blocking and process termination achieved equivalent containment |

## 6. Remediation Recommendations
- Password reset performed for account 'ligs'
- Malicious file /tmp/.update.sh removed and deletion confirmed
- System packages updated (apt update && apt upgrade)
- fail2ban installed and enabled to automatically block future brute-force attempts
- auditd exec-level logging enabled to close the command-execution visibility gap
  identified during this investigation
- Recommended (for production use): disable SSH password authentication in favor of
  key-based authentication, and disable direct root login

## 7. Lessons Learned
- Dynamic (DHCP) IP addressing on the investigator's own host created temporary
  ambiguity when correlating historical login events — real-time ARP/neighbor table
  capture during an active incident would prevent this kind of evidence aging out.
- Command-level audit logging (auditd exec rules) was not enabled by default, leaving
  a visibility gap for reconstructing attacker actions after initial access — now
  remediated.
- Multiple redundant instances of the malicious process were found running
  simultaneously, which should prompt a more thorough initial sweep for all related
  processes rather than assuming a single instance.

## 8. Appendix
- Evidence hash: 950e6fb133397c8a49345418e51cb18bcecb73bc8833c811d156f0bc5c86ecb8 (/tmp/.update.sh)
- Full command log available in indicators/analysis_summary.txt

