$ipaFilePath = "C:\Users\An\OneDrive\Desktop\IPA\TikTok 40.3.0.ipa"
$deviceUDIDs = @(
    "00008030-00154D8A3ED0402E",
	"00008030-000D59663C31402E",
    "00008030-0001559A262B802E",
	"00008030-000C50280238402E",
    "00008030-0011346C2E23402E",
	"00008030-0009508921C0402E",
	"00008030-000D2588019B402E",
    "00008030-0010591801E3402E",
    "00008030-0002605136D1402E",
    "00008030-001C14DA212B802E",
	"00008030-001455A43431402E",
	"00008030-0016096802B9402E",
	"00008030-001039DC0CEB802E",
	"00008030-000A18E911FA402E"
)

$jobs = @()

foreach ($udid in $deviceUDIDs) {
    Write-Host "Cài đặt ứng dụng trên thiết bị với UDID: $udid"
    
    # Tạo một tiến trình bất đồng bộ để cài đặt ứng dụng
    $jobs += Start-Job -ScriptBlock {
        param($udid, $ipaFilePath)
        
        # Chạy lệnh cài đặt
        & "D:\libimobiledevice\ideviceinstaller.exe" -u $udid -i $ipaFilePath
        
        Write-Host "Cài đặt hoàn tất trên thiết bị với UDID: $udid"
    } -ArgumentList $udid, $ipaFilePath
    
    # Tạm dừng 2 giây giữa các tiến trình để tránh tải quá nhiều
    Start-Sleep -Seconds 2
}

# Chờ tất cả các tiến trình hoàn tất
$jobs | Wait-Job

# Hiển thị kết quả
$jobs | Receive-Job

# Dọn dẹp các tiến trình
$jobs | Remove-Job

Write-Host "Tất cả các cài đặt đã hoàn thành!"