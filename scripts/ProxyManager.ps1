$registryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings"

function Get-SystemProxyStatus {
	return Get-ItemProperty -Path $registryPath -Name ProxyEnable
}

# Test-Proxy -proxyUri "http://192.168.1.2:7890"
function Test-Proxy ($proxyUri) {
	$request = @{
		ConnectionTimeoutSeconds = 2
		DisableKeepAlive         = $true
		Method                   = "Head"
		Proxy                    = New-Object System.Uri($proxyUri)
		Uri                      = "http://www.baidu.com"
	}

	try {
		$response = Invoke-WebRequest @request -ErrorAction SilentlyContinue
		return $response.StatusCode -eq 200
	}
	catch {
		return $false
	}
}

function Get-UsefulProxy {

}

function Set-GitProxy ($proxyUri) {
	git config --global http.proxy $proxyUri
	git config --global https.proxy $proxyUri
}

function Reset-GitProxy {
	git config --global --unset http.proxy
	git config --global --unset https.proxy
}

function Set-SystemProxy ($proxyUri) {
	$Env:all_proxy = $proxyUri
}

function Remove-Proxy {
	$Env:all_proxy = $null
}

function Set-CargoProxy {
	# https://bytedance.larkoffice.com/docx/Fa6vdnOgQoTDLcxGjwAcU0qdnCf
	$Env:RUSTUP_DIST_SERVER = "https://rsproxy.cn"
	$Env:RUSTUP_UPDATE_ROOT = "https://rsproxy.cn/rustup"
	$Env:CARGO_UNSTABLE_SPARSE_REGISTRY = 'true'
}
