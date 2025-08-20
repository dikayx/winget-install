Clear-Host

do {
    Write-Host "Press W/S to move, SPACE to select, ENTER to continue..." -ForegroundColor Cyan
    $key = [System.Console]::ReadKey($true)

    Write-Host "You pressed: $($key.Key) ($($key.KeyChar))"

    switch ($key.Key.ToString()) {
        "Enter" {
            Write-Host "Enter key detected. Breaking loop..." -ForegroundColor Green
            break
        }
        default {
            Write-Host "Other key pressed..."
        }
    }
} while ($true)

Write-Host "Finished input loop."
