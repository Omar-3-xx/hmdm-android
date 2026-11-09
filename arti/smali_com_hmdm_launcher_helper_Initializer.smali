.class public Lcom/hmdm/launcher/helper/Initializer;
.super Ljava/lang/Object;
.source "Initializer.java"


# static fields
.field private static executor:Ljava/util/concurrent/ExecutorService;

.field private static uiHandler:Landroid/os/Handler;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 47
    invoke-static {}, Ljava/util/concurrent/Executors;->newSingleThreadExecutor()Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    sput-object v0, Lcom/hmdm/launcher/helper/Initializer;->executor:Ljava/util/concurrent/ExecutorService;

    .line 48
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    sput-object v0, Lcom/hmdm/launcher/helper/Initializer;->uiHandler:Landroid/os/Handler;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 46
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static applyEarlyNonInteractivePolicies(Landroid/content/Context;Lcom/hmdm/launcher/json/ServerConfig;)V
    .locals 3

    .line 320
    invoke-virtual {p1}, Lcom/hmdm/launcher/json/ServerConfig;->getSystemUpdateType()Ljava/lang/Integer;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 321
    invoke-virtual {p1}, Lcom/hmdm/launcher/json/ServerConfig;->getSystemUpdateType()Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    if-eqz v0, :cond_0

    .line 322
    invoke-static {p0}, Lcom/hmdm/launcher/util/Utils;->isDeviceOwner(Landroid/content/Context;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 323
    invoke-virtual {p1}, Lcom/hmdm/launcher/json/ServerConfig;->getSystemUpdateType()Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    invoke-virtual {p1}, Lcom/hmdm/launcher/json/ServerConfig;->getSystemUpdateFrom()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1}, Lcom/hmdm/launcher/json/ServerConfig;->getSystemUpdateTo()Ljava/lang/String;

    move-result-object v2

    invoke-static {p0, v0, v1, v2}, Lcom/hmdm/launcher/util/Utils;->setSystemUpdatePolicy(Landroid/content/Context;ILjava/lang/String;Ljava/lang/String;)V

    .line 326
    :cond_0
    invoke-virtual {p1}, Lcom/hmdm/launcher/json/ServerConfig;->getBluetooth()Ljava/lang/Boolean;

    move-result-object v0

    if-eqz v0, :cond_2

    .line 328
    :try_start_0
    invoke-static {}, Landroid/bluetooth/BluetoothAdapter;->getDefaultAdapter()Landroid/bluetooth/BluetoothAdapter;

    move-result-object v0

    if-eqz v0, :cond_2

    .line 330
    invoke-virtual {v0}, Landroid/bluetooth/BluetoothAdapter;->isEnabled()Z

    move-result v1

    .line 331
    invoke-virtual {p1}, Lcom/hmdm/launcher/json/ServerConfig;->getBluetooth()Ljava/lang/Boolean;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v2

    if-eqz v2, :cond_1

    if-nez v1, :cond_1

    .line 332
    invoke-virtual {v0}, Landroid/bluetooth/BluetoothAdapter;->enable()Z

    goto :goto_0

    .line 333
    :cond_1
    invoke-virtual {p1}, Lcom/hmdm/launcher/json/ServerConfig;->getBluetooth()Ljava/lang/Boolean;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v2

    if-nez v2, :cond_2

    if-eqz v1, :cond_2

    .line 334
    invoke-virtual {v0}, Landroid/bluetooth/BluetoothAdapter;->disable()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .line 338
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 342
    :cond_2
    :goto_0
    invoke-virtual {p1}, Lcom/hmdm/launcher/json/ServerConfig;->getTimeZone()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_3

    .line 343
    invoke-virtual {p1}, Lcom/hmdm/launcher/json/ServerConfig;->getTimeZone()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, p0}, Lcom/hmdm/launcher/util/Utils;->setTimeZone(Ljava/lang/String;Landroid/content/Context;)Z

    .line 346
    :cond_3
    invoke-virtual {p1}, Lcom/hmdm/launcher/json/ServerConfig;->getUsbStorage()Ljava/lang/Boolean;

    move-result-object v0

    if-eqz v0, :cond_4

    .line 347
    invoke-virtual {p1}, Lcom/hmdm/launcher/json/ServerConfig;->getUsbStorage()Ljava/lang/Boolean;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    invoke-static {v0, p0}, Lcom/hmdm/launcher/util/Utils;->lockUsbStorage(ZLandroid/content/Context;)Z

    .line 351
    :cond_4
    invoke-virtual {p1}, Lcom/hmdm/launcher/json/ServerConfig;->getAutoBrightness()Ljava/lang/Boolean;

    move-result-object v0

    invoke-virtual {p1}, Lcom/hmdm/launcher/json/ServerConfig;->getBrightness()Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v0, v1, p0}, Lcom/hmdm/launcher/util/Utils;->setBrightnessPolicy(Ljava/lang/Boolean;Ljava/lang/Integer;Landroid/content/Context;)Z

    .line 352
    invoke-virtual {p1}, Lcom/hmdm/launcher/json/ServerConfig;->getManageTimeout()Ljava/lang/Boolean;

    move-result-object v0

    invoke-virtual {p1}, Lcom/hmdm/launcher/json/ServerConfig;->getTimeout()Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v0, v1, p0}, Lcom/hmdm/launcher/util/Utils;->setScreenTimeoutPolicy(Ljava/lang/Boolean;Ljava/lang/Integer;Landroid/content/Context;)Z

    .line 354
    invoke-virtual {p1}, Lcom/hmdm/launcher/json/ServerConfig;->getManageVolume()Ljava/lang/Boolean;

    move-result-object v0

    if-eqz v0, :cond_5

    invoke-virtual {p1}, Lcom/hmdm/launcher/json/ServerConfig;->getManageVolume()Ljava/lang/Boolean;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    if-eqz v0, :cond_5

    invoke-virtual {p1}, Lcom/hmdm/launcher/json/ServerConfig;->getVolume()Ljava/lang/Integer;

    move-result-object v0

    if-eqz v0, :cond_5

    const/4 v0, 0x0

    .line 355
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    invoke-static {v0, p0}, Lcom/hmdm/launcher/util/Utils;->lockVolume(Ljava/lang/Boolean;Landroid/content/Context;)Z

    .line 356
    invoke-virtual {p1}, Lcom/hmdm/launcher/json/ServerConfig;->getVolume()Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    invoke-static {v0, p0}, Lcom/hmdm/launcher/util/Utils;->setVolume(ILandroid/content/Context;)Z

    move-result v0

    if-nez v0, :cond_5

    const/4 v0, 0x2

    .line 357
    const-string v1, "Failed to set the device volume"

    invoke-static {p0, v0, v1}, Lcom/hmdm/launcher/util/RemoteLogger;->log(Landroid/content/Context;ILjava/lang/String;)V

    .line 361
    :cond_5
    invoke-virtual {p1}, Lcom/hmdm/launcher/json/ServerConfig;->getLockVolume()Ljava/lang/Boolean;

    move-result-object v0

    if-eqz v0, :cond_6

    .line 362
    invoke-virtual {p1}, Lcom/hmdm/launcher/json/ServerConfig;->getLockVolume()Ljava/lang/Boolean;

    move-result-object v0

    invoke-static {v0, p0}, Lcom/hmdm/launcher/util/Utils;->lockVolume(Ljava/lang/Boolean;Landroid/content/Context;)Z

    .line 365
    :cond_6
    invoke-virtual {p1}, Lcom/hmdm/launcher/json/ServerConfig;->isDisableScreenshots()Z

    move-result p1

    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p1

    invoke-static {p1, p0}, Lcom/hmdm/launcher/util/Utils;->disableScreenshots(Ljava/lang/Boolean;Landroid/content/Context;)Z

    return-void
.end method

.method public static init(Landroid/content/Context;Ljava/lang/Runnable;)V
    .locals 2

    .line 52
    sget-object v0, Lcom/hmdm/launcher/helper/Initializer;->executor:Ljava/util/concurrent/ExecutorService;

    new-instance v1, Lcom/hmdm/launcher/helper/Initializer$$ExternalSyntheticLambda0;

    invoke-direct {v1, p0, p1}, Lcom/hmdm/launcher/helper/Initializer$$ExternalSyntheticLambda0;-><init>(Landroid/content/Context;Ljava/lang/Runnable;)V

    invoke-interface {v0, v1}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V

    return-void
.end method

.method static synthetic lambda$init$0(Landroid/content/Context;Ljava/lang/Runnable;)V
    .locals 0

    .line 72
    invoke-static {p0}, Lcom/hmdm/launcher/pro/worker/DetailedInfoWorker;->schedule(Landroid/content/Context;)V

    .line 73
    invoke-static {p0}, Lcom/hmdm/launcher/worker/PushNotificationWorker;->schedule(Landroid/content/Context;)V

    .line 74
    invoke-static {p0}, Lcom/hmdm/launcher/worker/ScheduledAppUpdateWorker;->schedule(Landroid/content/Context;)V

    .line 77
    sget-object p0, Lcom/hmdm/launcher/helper/Initializer;->uiHandler:Landroid/os/Handler;

    invoke-virtual {p0, p1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method static synthetic lambda$init$1(Landroid/content/Context;Ljava/lang/Runnable;)V
    .locals 2

    .line 54
    invoke-static {p0}, Lcom/hmdm/launcher/pro/ProUtils;->initCrashlytics(Landroid/content/Context;)V

    .line 56
    sget-object v0, Lcom/hmdm/launcher/BuildConfig;->TRUST_ANY_CERTIFICATE:Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 57
    invoke-static {}, Lcom/hmdm/launcher/util/InstallUtils;->initUnsafeTrustManager()V

    .line 60
    :cond_0
    invoke-static {p0}, Lcom/hmdm/launcher/util/Utils;->lockSafeBoot(Landroid/content/Context;)Z

    .line 61
    invoke-static {p0}, Lcom/hmdm/launcher/util/Utils;->initPasswordReset(Landroid/content/Context;)V

    .line 63
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "MDM Launcher 6.48-"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-static {}, Lcom/hmdm/launcher/util/Utils;->getLauncherVariant()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " started"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x3

    invoke-static {p0, v1, v0}, Lcom/hmdm/launcher/util/RemoteLogger;->log(Landroid/content/Context;ILjava/lang/String;)V

    .line 65
    invoke-static {p0}, Lcom/hmdm/launcher/util/InstallUtils;->clearTempFiles(Landroid/content/Context;)V

    .line 69
    invoke-static {p0}, Lcom/hmdm/launcher/helper/CertInstaller;->installCertificatesFromAssets(Landroid/content/Context;)V

    .line 71
    new-instance v0, Lcom/hmdm/launcher/helper/Initializer$$ExternalSyntheticLambda1;

    invoke-direct {v0, p0, p1}, Lcom/hmdm/launcher/helper/Initializer$$ExternalSyntheticLambda1;-><init>(Landroid/content/Context;Ljava/lang/Runnable;)V

    invoke-static {p0, v0}, Lcom/hmdm/launcher/util/ConnectionWaiter;->waitForConnect(Landroid/content/Context;Ljava/lang/Runnable;)Z

    return-void
.end method

.method public static startLocationService(Landroid/content/Context;Lcom/hmdm/launcher/helper/SettingsHelper;)V
    .locals 2

    if-eqz p1, :cond_2

    .line 293
    :try_start_0
    invoke-virtual {p1}, Lcom/hmdm/launcher/helper/SettingsHelper;->getConfig()Lcom/hmdm/launcher/json/ServerConfig;

    move-result-object v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 296
    :cond_0
    invoke-virtual {p1}, Lcom/hmdm/launcher/helper/SettingsHelper;->getConfig()Lcom/hmdm/launcher/json/ServerConfig;

    move-result-object p1

    invoke-virtual {p1}, Lcom/hmdm/launcher/json/ServerConfig;->getRequestUpdates()Ljava/lang/String;

    move-result-object p1

    if-nez p1, :cond_1

    .line 302
    new-instance p1, Landroid/content/Intent;

    const-class v0, Lcom/hmdm/launcher/service/LocationService;

    invoke-direct {p1, p0, v0}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, p1}, Landroid/content/Context;->stopService(Landroid/content/Intent;)Z

    return-void

    .line 305
    :cond_1
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/hmdm/launcher/service/LocationService;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 306
    invoke-virtual {v0, p1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    .line 308
    invoke-virtual {p0, v0}, Landroid/content/Context;->startForegroundService(Landroid/content/Intent;)Landroid/content/ComponentName;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p0

    .line 313
    invoke-virtual {p0}, Ljava/lang/Exception;->printStackTrace()V

    :cond_2
    :goto_0
    return-void
.end method

.method public static startServicesAndLoadConfig(Landroid/content/Context;)V
    .locals 1

    const/4 v0, 0x1

    .line 83
    invoke-static {p0, v0}, Lcom/hmdm/launcher/helper/Initializer;->startServicesAndLoadConfig(Landroid/content/Context;Z)V

    return-void
.end method

.method public static startServicesAndLoadConfig(Landroid/content/Context;Z)V
    .locals 7

    .line 92
    invoke-static {p0}, Lcom/hmdm/launcher/helper/SettingsHelper;->getInstance(Landroid/content/Context;)Lcom/hmdm/launcher/helper/SettingsHelper;

    move-result-object v0

    const/16 v1, 0x12c

    if-eqz v0, :cond_0

    .line 93
    invoke-virtual {v0}, Lcom/hmdm/launcher/helper/SettingsHelper;->getConfig()Lcom/hmdm/launcher/json/ServerConfig;

    move-result-object v2

    if-eqz v2, :cond_0

    .line 94
    invoke-virtual {v0}, Lcom/hmdm/launcher/helper/SettingsHelper;->getConfig()Lcom/hmdm/launcher/json/ServerConfig;

    move-result-object v2

    invoke-virtual {v2}, Lcom/hmdm/launcher/json/ServerConfig;->getPushOptions()Ljava/lang/String;

    move-result-object v2

    .line 95
    invoke-virtual {v0}, Lcom/hmdm/launcher/helper/SettingsHelper;->getConfig()Lcom/hmdm/launcher/json/ServerConfig;

    move-result-object v3

    invoke-virtual {v3}, Lcom/hmdm/launcher/json/ServerConfig;->getKeepaliveTime()Ljava/lang/Integer;

    move-result-object v3

    if-eqz v3, :cond_1

    .line 96
    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v4

    const/16 v5, 0x1e

    if-lt v4, v5, :cond_1

    .line 97
    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v1

    goto :goto_0

    :cond_0
    const/4 v2, 0x0

    .line 100
    :cond_1
    :goto_0
    sget-object v3, Lcom/hmdm/launcher/BuildConfig;->MQTT_SERVICE_FOREGROUND:Ljava/lang/Boolean;

    invoke-virtual {v3}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v3

    const/4 v4, 0x1

    if-eqz v3, :cond_4

    if-eqz v2, :cond_4

    .line 101
    const-string v3, "mqttWorker"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_3

    const-string v3, "mqttAlarm"

    .line 102
    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_2

    goto :goto_1

    .line 122
    :cond_2
    const-string v1, "polling"

    invoke-virtual {v2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_4

    .line 124
    :try_start_0
    new-instance v1, Landroid/content/Intent;

    const-class v2, Lcom/hmdm/launcher/service/PushLongPollingService;

    invoke-direct {v1, p0, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 125
    const-string v2, "ENABLED"

    invoke-virtual {v1, v2, v4}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    .line 127
    invoke-virtual {p0, v1}, Landroid/content/Context;->startForegroundService(Landroid/content/Intent;)Landroid/content/ComponentName;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_2

    :catch_0
    move-exception v1

    .line 132
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_2

    .line 104
    :cond_3
    :goto_1
    :try_start_1
    new-instance v3, Ljava/net/URL;

    invoke-virtual {v0}, Lcom/hmdm/launcher/helper/SettingsHelper;->getBaseUrl()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v3, v5}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    .line 108
    new-instance v5, Landroid/content/Intent;

    invoke-direct {v5}, Landroid/content/Intent;-><init>()V

    .line 109
    const-string v6, "org.eclipse.paho.android.service.MqttService"

    invoke-virtual {v5, p0, v6}, Landroid/content/Intent;->setClassName(Landroid/content/Context;Ljava/lang/String;)Landroid/content/Intent;

    .line 110
    const-string v6, "START_AT_BOOT"

    invoke-virtual {v5, v6, v4}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    .line 111
    const-string v6, "DOMAIN"

    invoke-virtual {v3}, Ljava/net/URL;->getHost()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v5, v6, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 112
    const-string v3, "KEEPALIVE_TIME"

    invoke-virtual {v5, v3, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    .line 113
    const-string v1, "PUSH_OPTIONS"

    invoke-virtual {v5, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 114
    const-string v1, "DEVICE_ID"

    invoke-virtual {v0}, Lcom/hmdm/launcher/helper/SettingsHelper;->getDeviceId()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v5, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 116
    invoke-virtual {p0, v5}, Landroid/content/Context;->startForegroundService(Landroid/content/Intent;)Landroid/content/ComponentName;

    .line 118
    const-string v1, "HeadwindMDM"

    const-string v2, "Starting Push service from BootReceiver"

    invoke-static {v1, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_2

    :catch_1
    move-exception v1

    .line 120
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    .line 142
    :cond_4
    :goto_2
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    const-string v2, "PREFERENCES"

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v1

    .line 144
    const-string v2, "PREFERENCES_USAGE_STATISTICS"

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v2

    if-ne v2, v4, :cond_5

    .line 146
    :try_start_2
    new-instance v2, Landroid/content/Intent;

    const-class v5, Lcom/hmdm/launcher/pro/service/CheckForegroundApplicationService;

    invoke-direct {v2, p0, v5}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, v2}, Landroid/content/Context;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_2

    goto :goto_3

    :catch_2
    move-exception v2

    .line 148
    invoke-virtual {v2}, Ljava/lang/Exception;->printStackTrace()V

    .line 151
    :cond_5
    :goto_3
    sget-object v2, Lcom/hmdm/launcher/BuildConfig;->USE_ACCESSIBILITY:Ljava/lang/Boolean;

    invoke-virtual {v2}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v2

    if-eqz v2, :cond_6

    const-string v2, "PREFERENCES_ACCESSIBILITY_SERVICE"

    .line 152
    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v1

    if-ne v1, v4, :cond_6

    .line 154
    :try_start_3
    new-instance v1, Landroid/content/Intent;

    const-class v2, Lcom/hmdm/launcher/pro/service/CheckForegroundAppAccessibilityService;

    invoke-direct {v1, p0, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, v1}, Landroid/content/Context;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_3

    goto :goto_4

    :catch_3
    move-exception v1

    .line 156
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    .line 160
    :cond_6
    :goto_4
    :try_start_4
    new-instance v1, Landroid/content/Intent;

    const-class v2, Lcom/hmdm/launcher/service/StatusControlService;

    invoke-direct {v1, p0, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, v1}, Landroid/content/Context;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_4

    goto :goto_5

    :catch_4
    move-exception v1

    .line 162
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    .line 169
    :goto_5
    invoke-static {p0, v4}, Lcom/hmdm/launcher/util/Utils;->setStatusBarDisabled(Landroid/content/Context;Z)V

    .line 171
    :try_start_5
    new-instance v1, Landroid/content/Intent;

    const-class v2, Lcom/hmdm/launcher/service/StatusBarOverlayService;

    invoke-direct {v1, p0, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 173
    invoke-virtual {p0, v1}, Landroid/content/Context;->startForegroundService(Landroid/content/Intent;)Landroid/content/ComponentName;
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_5

    goto :goto_6

    :catch_5
    move-exception v1

    .line 178
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    .line 189
    :goto_6
    invoke-static {p0, v0}, Lcom/hmdm/launcher/helper/Initializer;->startLocationService(Landroid/content/Context;Lcom/hmdm/launcher/helper/SettingsHelper;)V

    if-eqz p1, :cond_7

    .line 198
    :try_start_6
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object p1

    const-string v1, "remote_access_package"

    invoke-virtual {v0, p1, v1}, Lcom/hmdm/launcher/helper/SettingsHelper;->getAppPreference(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    .line 197
    invoke-static {p0, p1}, Lcom/hmdm/launcher/util/Utils;->startRemoteAccessApp(Landroid/content/Context;Ljava/lang/String;)V
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_6

    goto :goto_7

    :catch_6
    move-exception p1

    .line 200
    invoke-virtual {p1}, Ljava/lang/Exception;->printStackTrace()V

    .line 205
    :cond_7
    :goto_7
    invoke-static {p0}, Lcom/hmdm/launcher/util/RemoteLogger;->sendLogsToServer(Landroid/content/Context;)V

    .line 207
    new-instance p1, Lcom/hmdm/launcher/helper/Initializer$1;

    invoke-direct {p1, p0}, Lcom/hmdm/launcher/helper/Initializer$1;-><init>(Landroid/content/Context;)V

    .line 285
    invoke-static {p0, p1, v3}, Lcom/hmdm/launcher/helper/ConfigUpdater;->forceConfigUpdate(Landroid/content/Context;Lcom/hmdm/launcher/helper/ConfigUpdater$UINotifier;Z)V

    return-void
.end method
