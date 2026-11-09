.class public Lcom/hmdm/launcher/service/StatusBarOverlayService;
.super Landroid/app/Service;
.source "StatusBarOverlayService.java"


# static fields
.field private static final CHANNEL_ID:Ljava/lang/String; = "phx_status_bar"

.field private static final NOTIFICATION_ID:I = 0xb0

.field private static final WIFI_UPDATE_INTERVAL_MS:J = 0x2710L


# instance fields
.field private barView:Landroid/view/View;

.field private final handler:Landroid/os/Handler;

.field private final statusBarUpdater:Lcom/hmdm/launcher/ui/custom/StatusBarUpdater;

.field private final wifiRunnable:Ljava/lang/Runnable;

.field private wifiView:Landroid/widget/ImageView;

.field private windowManager:Landroid/view/WindowManager;


# direct methods
.method public constructor <init>()V
    .locals 2

    .line 58
    invoke-direct {p0}, Landroid/app/Service;-><init>()V

    .line 67
    new-instance v0, Lcom/hmdm/launcher/ui/custom/StatusBarUpdater;

    invoke-direct {v0}, Lcom/hmdm/launcher/ui/custom/StatusBarUpdater;-><init>()V

    iput-object v0, p0, Lcom/hmdm/launcher/service/StatusBarOverlayService;->statusBarUpdater:Lcom/hmdm/launcher/ui/custom/StatusBarUpdater;

    .line 68
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v0, p0, Lcom/hmdm/launcher/service/StatusBarOverlayService;->handler:Landroid/os/Handler;

    .line 70
    new-instance v0, Lcom/hmdm/launcher/service/StatusBarOverlayService$1;

    invoke-direct {v0, p0}, Lcom/hmdm/launcher/service/StatusBarOverlayService$1;-><init>(Lcom/hmdm/launcher/service/StatusBarOverlayService;)V

    iput-object v0, p0, Lcom/hmdm/launcher/service/StatusBarOverlayService;->wifiRunnable:Ljava/lang/Runnable;

    return-void
.end method

.method static synthetic access$000(Lcom/hmdm/launcher/service/StatusBarOverlayService;)V
    .locals 0

    .line 58
    invoke-direct {p0}, Lcom/hmdm/launcher/service/StatusBarOverlayService;->updateWifi()V

    return-void
.end method

.method static synthetic access$100(Lcom/hmdm/launcher/service/StatusBarOverlayService;)Landroid/os/Handler;
    .locals 0

    .line 58
    iget-object p0, p0, Lcom/hmdm/launcher/service/StatusBarOverlayService;->handler:Landroid/os/Handler;

    return-object p0
.end method

.method private addOverlay()V
    .locals 14

    .line 116
    invoke-virtual {p0}, Lcom/hmdm/launcher/service/StatusBarOverlayService;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    const-string v1, "window"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManager;

    iput-object v0, p0, Lcom/hmdm/launcher/service/StatusBarOverlayService;->windowManager:Landroid/view/WindowManager;

    if-nez v0, :cond_0

    return-void

    .line 121
    :cond_0
    new-instance v0, Landroid/widget/LinearLayout;

    invoke-direct {v0, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    const/4 v1, 0x0

    .line 122
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setOrientation(I)V

    const/16 v2, 0x10

    .line 123
    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->setGravity(I)V

    const/high16 v3, -0x1000000

    .line 124
    invoke-virtual {v0, v3}, Landroid/widget/LinearLayout;->setBackgroundColor(I)V

    const/16 v3, 0x8

    .line 125
    invoke-direct {p0, v3}, Lcom/hmdm/launcher/service/StatusBarOverlayService;->dp(I)I

    move-result v4

    .line 126
    invoke-virtual {v0, v4, v1, v4, v1}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 128
    new-instance v4, Landroid/widget/TextView;

    invoke-direct {v4, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    const/4 v5, -0x1

    .line 129
    invoke-virtual {v4, v5}, Landroid/widget/TextView;->setTextColor(I)V

    const/4 v5, 0x2

    const/high16 v6, 0x41400000    # 12.0f

    .line 130
    invoke-virtual {v4, v5, v6}, Landroid/widget/TextView;->setTextSize(IF)V

    .line 131
    new-instance v5, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v6, 0x3f800000    # 1.0f

    const/4 v7, -0x2

    invoke-direct {v5, v1, v7, v6}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 133
    invoke-virtual {v0, v4, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 135
    new-instance v1, Landroid/widget/ImageView;

    invoke-direct {v1, p0}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    iput-object v1, p0, Lcom/hmdm/launcher/service/StatusBarOverlayService;->wifiView:Landroid/widget/ImageView;

    const v5, 0x7f08008d

    .line 136
    invoke-virtual {v1, v5}, Landroid/widget/ImageView;->setImageResource(I)V

    .line 137
    invoke-direct {p0, v2}, Lcom/hmdm/launcher/service/StatusBarOverlayService;->dp(I)I

    move-result v1

    .line 138
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v2, v1, v1}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 139
    invoke-direct {p0, v3}, Lcom/hmdm/launcher/service/StatusBarOverlayService;->dp(I)I

    move-result v1

    iput v1, v2, Landroid/widget/LinearLayout$LayoutParams;->rightMargin:I

    .line 140
    iget-object v1, p0, Lcom/hmdm/launcher/service/StatusBarOverlayService;->wifiView:Landroid/widget/ImageView;

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 142
    new-instance v1, Lcom/hmdm/launcher/ui/custom/BatteryStateView;

    invoke-direct {v1, p0}, Lcom/hmdm/launcher/ui/custom/BatteryStateView;-><init>(Landroid/content/Context;)V

    .line 143
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v2, v7, v7}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 149
    new-instance v8, Landroid/view/WindowManager$LayoutParams;

    .line 151
    invoke-direct {p0}, Lcom/hmdm/launcher/service/StatusBarOverlayService;->statusBarHeight()I

    move-result v10

    const/16 v12, 0x318

    const/4 v13, -0x3

    const/4 v9, -0x1

    const/16 v11, 0x7f6

    invoke-direct/range {v8 .. v13}, Landroid/view/WindowManager$LayoutParams;-><init>(IIIII)V

    const v2, 0x800033

    .line 158
    iput v2, v8, Landroid/view/WindowManager$LayoutParams;->gravity:I

    .line 160
    iget-object v2, p0, Lcom/hmdm/launcher/service/StatusBarOverlayService;->windowManager:Landroid/view/WindowManager;

    invoke-interface {v2, v0, v8}, Landroid/view/WindowManager;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 161
    iput-object v0, p0, Lcom/hmdm/launcher/service/StatusBarOverlayService;->barView:Landroid/view/View;

    .line 164
    iget-object v0, p0, Lcom/hmdm/launcher/service/StatusBarOverlayService;->statusBarUpdater:Lcom/hmdm/launcher/ui/custom/StatusBarUpdater;

    invoke-virtual {v0, p0, v4, v1}, Lcom/hmdm/launcher/ui/custom/StatusBarUpdater;->startUpdating(Landroid/content/Context;Landroid/widget/TextView;Lcom/hmdm/launcher/ui/custom/BatteryStateView;)V

    .line 165
    iget-object v0, p0, Lcom/hmdm/launcher/service/StatusBarOverlayService;->statusBarUpdater:Lcom/hmdm/launcher/ui/custom/StatusBarUpdater;

    const/4 v1, 0x1

    invoke-virtual {v0, v1, v1}, Lcom/hmdm/launcher/ui/custom/StatusBarUpdater;->updateControlsState(ZZ)V

    .line 167
    iget-object v0, p0, Lcom/hmdm/launcher/service/StatusBarOverlayService;->handler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/hmdm/launcher/service/StatusBarOverlayService;->wifiRunnable:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 168
    iget-object v0, p0, Lcom/hmdm/launcher/service/StatusBarOverlayService;->handler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/hmdm/launcher/service/StatusBarOverlayService;->wifiRunnable:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method private dp(I)I
    .locals 1

    int-to-float p1, p1

    .line 198
    invoke-virtual {p0}, Lcom/hmdm/launcher/service/StatusBarOverlayService;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    mul-float/2addr p1, v0

    invoke-static {p1}, Ljava/lang/Math;->round(F)I

    move-result p1

    return p1
.end method

.method private startInForeground()V
    .locals 6

    .line 95
    const-string v0, "notification"

    invoke-virtual {p0, v0}, Lcom/hmdm/launcher/service/StatusBarOverlayService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/NotificationManager;

    const/4 v1, 0x1

    const v2, 0x7f10002b

    .line 96
    const-string v3, "phx_status_bar"

    if-eqz v0, :cond_0

    .line 97
    new-instance v4, Landroid/app/NotificationChannel;

    .line 98
    invoke-virtual {p0, v2}, Lcom/hmdm/launcher/service/StatusBarOverlayService;->getString(I)Ljava/lang/String;

    move-result-object v5

    invoke-direct {v4, v3, v5, v1}, Landroid/app/NotificationChannel;-><init>(Ljava/lang/String;Ljava/lang/CharSequence;I)V

    const/4 v5, 0x0

    .line 99
    invoke-virtual {v4, v5}, Landroid/app/NotificationChannel;->setShowBadge(Z)V

    .line 100
    invoke-virtual {v0, v4}, Landroid/app/NotificationManager;->createNotificationChannel(Landroid/app/NotificationChannel;)V

    .line 102
    :cond_0
    new-instance v0, Landroidx/core/app/NotificationCompat$Builder;

    invoke-direct {v0, p0, v3}, Landroidx/core/app/NotificationCompat$Builder;-><init>(Landroid/content/Context;Ljava/lang/String;)V

    const/high16 v3, 0x7f0d0000

    .line 103
    invoke-virtual {v0, v3}, Landroidx/core/app/NotificationCompat$Builder;->setSmallIcon(I)Landroidx/core/app/NotificationCompat$Builder;

    move-result-object v0

    .line 104
    invoke-virtual {p0, v2}, Lcom/hmdm/launcher/service/StatusBarOverlayService;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroidx/core/app/NotificationCompat$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroidx/core/app/NotificationCompat$Builder;

    move-result-object v0

    const/4 v2, -0x2

    .line 105
    invoke-virtual {v0, v2}, Landroidx/core/app/NotificationCompat$Builder;->setPriority(I)Landroidx/core/app/NotificationCompat$Builder;

    move-result-object v0

    .line 106
    invoke-virtual {v0, v1}, Landroidx/core/app/NotificationCompat$Builder;->setOngoing(Z)Landroidx/core/app/NotificationCompat$Builder;

    move-result-object v0

    .line 107
    invoke-virtual {v0}, Landroidx/core/app/NotificationCompat$Builder;->build()Landroid/app/Notification;

    move-result-object v0

    const/16 v1, 0xb0

    .line 109
    :try_start_0
    invoke-virtual {p0, v1, v0}, Lcom/hmdm/launcher/service/StatusBarOverlayService;->startForeground(ILandroid/app/Notification;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    .line 111
    const-string v1, "HeadwindMDM"

    const-string v2, "StatusBarOverlayService: startForeground failed"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    return-void
.end method

.method private statusBarHeight()I
    .locals 4

    .line 190
    invoke-virtual {p0}, Lcom/hmdm/launcher/service/StatusBarOverlayService;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "dimen"

    const-string v2, "android"

    const-string v3, "status_bar_height"

    invoke-virtual {v0, v3, v1, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    if-lez v0, :cond_0

    .line 192
    invoke-virtual {p0}, Lcom/hmdm/launcher/service/StatusBarOverlayService;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v0

    return v0

    :cond_0
    const/16 v0, 0x18

    .line 194
    invoke-direct {p0, v0}, Lcom/hmdm/launcher/service/StatusBarOverlayService;->dp(I)I

    move-result v0

    return v0
.end method

.method private updateWifi()V
    .locals 3

    .line 172
    iget-object v0, p0, Lcom/hmdm/launcher/service/StatusBarOverlayService;->wifiView:Landroid/widget/ImageView;

    if-nez v0, :cond_0

    return-void

    :cond_0
    const/4 v0, 0x0

    .line 178
    :try_start_0
    invoke-virtual {p0}, Lcom/hmdm/launcher/service/StatusBarOverlayService;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    const-string v2, "wifi"

    invoke-virtual {v1, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/net/wifi/WifiManager;

    if-eqz v1, :cond_1

    .line 179
    invoke-virtual {v1}, Landroid/net/wifi/WifiManager;->isWifiEnabled()Z

    move-result v2

    if-eqz v2, :cond_1

    .line 180
    invoke-virtual {v1}, Landroid/net/wifi/WifiManager;->getConnectionInfo()Landroid/net/wifi/WifiInfo;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 181
    invoke-virtual {v1}, Landroid/net/wifi/WifiInfo;->getNetworkId()I

    move-result v1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v2, -0x1

    if-eq v1, v2, :cond_1

    const/4 v0, 0x1

    .line 186
    :catch_0
    :cond_1
    iget-object v1, p0, Lcom/hmdm/launcher/service/StatusBarOverlayService;->wifiView:Landroid/widget/ImageView;

    if-eqz v0, :cond_2

    const/high16 v0, 0x3f800000    # 1.0f

    goto :goto_0

    :cond_2
    const v0, 0x3e99999a    # 0.3f

    :goto_0
    invoke-virtual {v1, v0}, Landroid/widget/ImageView;->setAlpha(F)V

    return-void
.end method


# virtual methods
.method public onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    .locals 0

    const/4 p1, 0x0

    return-object p1
.end method

.method public onDestroy()V
    .locals 2

    .line 203
    iget-object v0, p0, Lcom/hmdm/launcher/service/StatusBarOverlayService;->handler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/hmdm/launcher/service/StatusBarOverlayService;->wifiRunnable:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 204
    iget-object v0, p0, Lcom/hmdm/launcher/service/StatusBarOverlayService;->statusBarUpdater:Lcom/hmdm/launcher/ui/custom/StatusBarUpdater;

    invoke-virtual {v0}, Lcom/hmdm/launcher/ui/custom/StatusBarUpdater;->stopUpdating()V

    .line 205
    iget-object v0, p0, Lcom/hmdm/launcher/service/StatusBarOverlayService;->barView:Landroid/view/View;

    if-eqz v0, :cond_0

    iget-object v1, p0, Lcom/hmdm/launcher/service/StatusBarOverlayService;->windowManager:Landroid/view/WindowManager;

    if-eqz v1, :cond_0

    .line 207
    :try_start_0
    invoke-interface {v1, v0}, Landroid/view/WindowManager;->removeView(Landroid/view/View;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    const/4 v0, 0x0

    .line 211
    iput-object v0, p0, Lcom/hmdm/launcher/service/StatusBarOverlayService;->barView:Landroid/view/View;

    .line 213
    :cond_0
    invoke-super {p0}, Landroid/app/Service;->onDestroy()V

    return-void
.end method

.method public onStartCommand(Landroid/content/Intent;II)I
    .locals 0

    .line 80
    invoke-direct {p0}, Lcom/hmdm/launcher/service/StatusBarOverlayService;->startInForeground()V

    .line 81
    iget-object p1, p0, Lcom/hmdm/launcher/service/StatusBarOverlayService;->barView:Landroid/view/View;

    if-nez p1, :cond_0

    .line 83
    :try_start_0
    invoke-direct {p0}, Lcom/hmdm/launcher/service/StatusBarOverlayService;->addOverlay()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    .line 88
    const-string p2, "HeadwindMDM"

    const-string p3, "StatusBarOverlayService: could not add the overlay bar"

    invoke-static {p2, p3, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :cond_0
    :goto_0
    const/4 p1, 0x1

    return p1
.end method
