.class public Lcom/hmdm/launcher/util/Utils;
.super Ljava/lang/Object;
.source "Utils.java"


# static fields
.field private static final DEFAULT_REMOTE_ACCESS_PACKAGE:Ljava/lang/String; = "com.carriez.flutter_hbb"

.field public static final FRP_ACCOUNTS_SETTING:Ljava/lang/String; = "frp_accounts"

.field public static final OWNER_LOCK_SCREEN_INFO:Ljava/lang/String; = "This device belongs to Sato Pharma"

.field public static final OWNER_ORGANIZATION:Ljava/lang/String; = "Sato Pharma"

.field private static final PROTECTIVE_RESTRICTIONS:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field public static final REMOTE_ACCESS_PACKAGE_SETTING:Ljava/lang/String; = "remote_access_package"


# direct methods
.method static constructor <clinit>()V
    .locals 4

    .line 104
    new-instance v0, Ljava/util/HashSet;

    const/4 v1, 0x4

    new-array v1, v1, [Ljava/lang/String;

    const/4 v2, 0x0

    const-string v3, "no_factory_reset"

    aput-object v3, v1, v2

    const/4 v2, 0x1

    const-string v3, "no_safe_boot"

    aput-object v3, v1, v2

    const/4 v2, 0x2

    const-string v3, "no_debugging_features"

    aput-object v3, v1, v2

    const/4 v2, 0x3

    const-string v3, "no_add_user"

    aput-object v3, v1, v2

    invoke-static {v1}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/util/HashSet;-><init>(Ljava/util/Collection;)V

    sput-object v0, Lcom/hmdm/launcher/util/Utils;->PROTECTIVE_RESTRICTIONS:Ljava/util/Set;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 75
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static OverlayWindowType()I
    .locals 1

    const/16 v0, 0x7f6

    return v0
.end method

.method public static applyFactoryResetProtection(Landroid/content/Context;Ljava/lang/String;)V
    .locals 9

    if-eqz p1, :cond_7

    .line 134
    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    goto/16 :goto_1

    .line 137
    :cond_0
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1e

    if-lt v0, v1, :cond_7

    invoke-static {p0}, Lcom/hmdm/launcher/util/Utils;->isDeviceOwner(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :cond_1

    goto/16 :goto_1

    :cond_1
    const/4 v0, 0x2

    .line 141
    :try_start_0
    const-string v1, "device_policy"

    invoke-virtual {p0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/app/admin/DevicePolicyManager;

    .line 142
    invoke-static {p0}, Lcom/hmdm/launcher/util/LegacyUtils;->getAdminComponentName(Landroid/content/Context;)Landroid/content/ComponentName;

    move-result-object v2

    if-eqz v1, :cond_7

    if-nez v2, :cond_2

    goto/16 :goto_1

    .line 146
    :cond_2
    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v3

    const-string v4, "off"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v3

    const/4 v4, 0x3

    if-eqz v3, :cond_3

    const/4 p1, 0x0

    .line 147
    invoke-virtual {v1, v2, p1}, Landroid/app/admin/DevicePolicyManager;->setFactoryResetProtectionPolicy(Landroid/content/ComponentName;Landroid/app/admin/FactoryResetProtectionPolicy;)V

    .line 148
    const-string p1, "Factory reset protection removed"

    invoke-static {p0, v4, p1}, Lcom/hmdm/launcher/util/RemoteLogger;->log(Landroid/content/Context;ILjava/lang/String;)V

    return-void

    .line 151
    :cond_3
    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    .line 152
    const-string v5, ","

    invoke-virtual {p1, v5}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object p1

    array-length v5, p1

    const/4 v6, 0x0

    :goto_0
    if-ge v6, v5, :cond_5

    aget-object v7, p1, v6

    .line 153
    invoke-virtual {v7}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v7

    .line 154
    const-string v8, "\\d{5,30}"

    invoke-virtual {v7, v8}, Ljava/lang/String;->matches(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_4

    .line 155
    invoke-interface {v3, v7}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_4
    add-int/lit8 v6, v6, 0x1

    goto :goto_0

    .line 158
    :cond_5
    invoke-interface {v3}, Ljava/util/List;->isEmpty()Z

    move-result p1

    if-eqz p1, :cond_6

    .line 159
    const-string p1, "Factory reset protection not set: no valid Google account ID"

    invoke-static {p0, v0, p1}, Lcom/hmdm/launcher/util/RemoteLogger;->log(Landroid/content/Context;ILjava/lang/String;)V

    return-void

    .line 162
    :cond_6
    new-instance p1, Landroid/app/admin/FactoryResetProtectionPolicy$Builder;

    invoke-direct {p1}, Landroid/app/admin/FactoryResetProtectionPolicy$Builder;-><init>()V

    .line 163
    invoke-virtual {p1, v3}, Landroid/app/admin/FactoryResetProtectionPolicy$Builder;->setFactoryResetProtectionAccounts(Ljava/util/List;)Landroid/app/admin/FactoryResetProtectionPolicy$Builder;

    move-result-object p1

    const/4 v5, 0x1

    .line 164
    invoke-virtual {p1, v5}, Landroid/app/admin/FactoryResetProtectionPolicy$Builder;->setFactoryResetProtectionEnabled(Z)Landroid/app/admin/FactoryResetProtectionPolicy$Builder;

    move-result-object p1

    .line 165
    invoke-virtual {p1}, Landroid/app/admin/FactoryResetProtectionPolicy$Builder;->build()Landroid/app/admin/FactoryResetProtectionPolicy;

    move-result-object p1

    .line 162
    invoke-virtual {v1, v2, p1}, Landroid/app/admin/DevicePolicyManager;->setFactoryResetProtectionPolicy(Landroid/content/ComponentName;Landroid/app/admin/FactoryResetProtectionPolicy;)V

    .line 166
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Factory reset protection set for "

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v1

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v1, " account(s)"

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p0, v4, p1}, Lcom/hmdm/launcher/util/RemoteLogger;->log(Landroid/content/Context;ILjava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    .line 168
    invoke-virtual {p1}, Ljava/lang/Exception;->printStackTrace()V

    .line 169
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "Factory reset protection failed: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p0, v0, p1}, Lcom/hmdm/launcher/util/RemoteLogger;->log(Landroid/content/Context;ILjava/lang/String;)V

    :cond_7
    :goto_1
    return-void
.end method

.method public static applyOwnerInfo(Landroid/content/Context;)V
    .locals 2

    .line 213
    invoke-static {p0}, Lcom/hmdm/launcher/util/Utils;->isDeviceOwner(Landroid/content/Context;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 217
    :try_start_0
    const-string v0, "device_policy"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/admin/DevicePolicyManager;

    .line 218
    invoke-static {p0}, Lcom/hmdm/launcher/util/LegacyUtils;->getAdminComponentName(Landroid/content/Context;)Landroid/content/ComponentName;

    move-result-object p0

    if-eqz v0, :cond_1

    if-nez p0, :cond_0

    goto :goto_0

    .line 222
    :cond_0
    const-string v1, "Sato Pharma"

    invoke-virtual {v0, p0, v1}, Landroid/app/admin/DevicePolicyManager;->setOrganizationName(Landroid/content/ComponentName;Ljava/lang/CharSequence;)V

    .line 223
    const-string v1, "This device belongs to Sato Pharma"

    invoke-virtual {v0, p0, v1}, Landroid/app/admin/DevicePolicyManager;->setDeviceOwnerLockScreenInfo(Landroid/content/ComponentName;Ljava/lang/CharSequence;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p0

    .line 225
    invoke-virtual {p0}, Ljava/lang/Exception;->printStackTrace()V

    :cond_1
    :goto_0
    return-void
.end method

.method public static applyPhoenixDeviceState(Landroid/content/Context;Ljava/lang/String;)V
    .locals 0

    .line 200
    invoke-static {p1}, Lcom/hmdm/launcher/util/Utils;->resolveRemoteAccessPackage(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    .line 201
    invoke-static {p0}, Lcom/hmdm/launcher/util/Utils;->forceLocationOn(Landroid/content/Context;)V

    .line 202
    invoke-static {p0, p1}, Lcom/hmdm/launcher/util/Utils;->grantRemoteAccessPermissions(Landroid/content/Context;Ljava/lang/String;)V

    .line 203
    invoke-static {p0}, Lcom/hmdm/launcher/util/Utils;->applyOwnerInfo(Landroid/content/Context;)V

    .line 204
    invoke-static {p0, p1}, Lcom/hmdm/launcher/util/Utils;->reportPhoenixStatus(Landroid/content/Context;Ljava/lang/String;)V

    return-void
.end method

.method public static autoGrantPhonePermission(Landroid/content/Context;)Z
    .locals 7

    .line 395
    const-string v0, "android.permission.READ_PHONE_NUMBERS"

    const-string v1, "android.permission.READ_PHONE_STATE"

    const/4 v2, 0x0

    :try_start_0
    const-string v3, "device_policy"

    invoke-virtual {p0, v3}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/app/admin/DevicePolicyManager;

    .line 397
    invoke-static {p0}, Lcom/hmdm/launcher/util/LegacyUtils;->getAdminComponentName(Landroid/content/Context;)Landroid/content/ComponentName;

    move-result-object v4

    .line 400
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v5

    .line 399
    invoke-virtual {v3, v4, v5, v1}, Landroid/app/admin/DevicePolicyManager;->getPermissionGrantState(Landroid/content/ComponentName;Ljava/lang/String;Ljava/lang/String;)I

    move-result v5

    const/4 v6, 0x1

    if-eq v5, v6, :cond_0

    .line 402
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v5

    .line 401
    invoke-virtual {v3, v4, v5, v1, v6}, Landroid/app/admin/DevicePolicyManager;->setPermissionGrantState(Landroid/content/ComponentName;Ljava/lang/String;Ljava/lang/String;I)Z

    move-result v1

    if-nez v1, :cond_0

    return v2

    .line 409
    :cond_0
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    .line 408
    invoke-virtual {v3, v4, v1, v0}, Landroid/app/admin/DevicePolicyManager;->getPermissionGrantState(Landroid/content/ComponentName;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    if-eq v1, v6, :cond_1

    .line 411
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object p0

    .line 410
    invoke-virtual {v3, v4, p0, v0, v6}, Landroid/app/admin/DevicePolicyManager;->setPermissionGrantState(Landroid/content/ComponentName;Ljava/lang/String;Ljava/lang/String;I)Z

    move-result p0
    :try_end_0
    .catch Ljava/lang/NoSuchMethodError; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    if-nez p0, :cond_1

    return v2

    .line 436
    :cond_1
    const-string p0, "HeadwindMDM"

    const-string v0, "READ_PHONE_STATE automatically granted"

    invoke-static {p0, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    return v6

    :catch_0
    move-exception p0

    .line 433
    invoke-virtual {p0}, Ljava/lang/Exception;->printStackTrace()V

    return v2

    :catch_1
    move-exception p0

    .line 429
    invoke-virtual {p0}, Ljava/lang/NoSuchMethodError;->printStackTrace()V

    return v2
.end method

.method public static autoGrantRequestedPermissions(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Z)Z
    .locals 10

    .line 490
    const-string v0, "asklocation"

    invoke-virtual {v0, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-eqz v0, :cond_1

    :cond_0
    move p2, v1

    :goto_0
    move v0, v2

    goto :goto_2

    .line 492
    :cond_1
    const-string v0, "denylocation"

    invoke-virtual {v0, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    const/4 p2, 0x2

    goto :goto_0

    .line 494
    :cond_2
    const-string v0, "askall"

    invoke-virtual {v0, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p2

    if-eqz p2, :cond_3

    .line 496
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p2

    if-nez p2, :cond_0

    move p2, v1

    goto :goto_1

    :cond_3
    move p2, v2

    :goto_1
    move v0, p2

    .line 501
    :goto_2
    const-string v3, "device_policy"

    invoke-virtual {p0, v3}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/app/admin/DevicePolicyManager;

    .line 503
    invoke-static {p0}, Lcom/hmdm/launcher/util/LegacyUtils;->getAdminComponentName(Landroid/content/Context;)Landroid/content/ComponentName;

    move-result-object v4

    .line 506
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object p0

    invoke-static {p0, p1}, Lcom/hmdm/launcher/util/Utils;->getRuntimePermissions(Landroid/content/pm/PackageManager;Ljava/lang/String;)Ljava/util/List;

    move-result-object p0

    if-eqz p3, :cond_8

    .line 515
    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p3

    move v5, v1

    move v6, v5

    :cond_4
    :goto_3
    invoke-interface {p3}, Ljava/util/Iterator;->hasNext()Z

    move-result v7
    :try_end_0
    .catch Ljava/lang/NoSuchMethodError; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const-string v8, "android.permission.WRITE_EXTERNAL_STORAGE"

    const-string v9, "android.permission.READ_EXTERNAL_STORAGE"

    if-eqz v7, :cond_6

    :try_start_1
    invoke-interface {p3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/String;

    .line 516
    invoke-virtual {v7, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_5

    move v5, v2

    .line 519
    :cond_5
    invoke-virtual {v7, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_4

    move v6, v2

    goto :goto_3

    :cond_6
    if-nez v5, :cond_7

    .line 524
    invoke-interface {p0, v9}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_7
    if-nez v6, :cond_8

    .line 527
    invoke-interface {p0, v8}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 531
    :cond_8
    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :cond_9
    :goto_4
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result p3
    :try_end_1
    .catch Ljava/lang/NoSuchMethodError; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    const-string v5, "HeadwindMDM"

    if-eqz p3, :cond_c

    :try_start_2
    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object p3

    check-cast p3, Ljava/lang/String;

    .line 532
    invoke-static {p3}, Lcom/hmdm/launcher/util/Utils;->isLocationPermission(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_a

    move v6, p2

    goto :goto_5

    :cond_a
    move v6, v0

    .line 533
    :goto_5
    invoke-virtual {v3, v4, p1, p3}, Landroid/app/admin/DevicePolicyManager;->getPermissionGrantState(Landroid/content/ComponentName;Ljava/lang/String;Ljava/lang/String;)I

    move-result v7

    if-eq v7, v6, :cond_9

    .line 535
    invoke-virtual {v3, v4, p1, p3, v6}, Landroid/app/admin/DevicePolicyManager;->setPermissionGrantState(Landroid/content/ComponentName;Ljava/lang/String;Ljava/lang/String;I)Z

    move-result v6

    if-nez v6, :cond_b

    .line 538
    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    const-string p1, "Failed to grant permission "

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {v5, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return v1

    .line 541
    :cond_b
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Permission "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p3

    const-string v6, " granted to package "

    invoke-virtual {p3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p3

    invoke-virtual {p3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p3

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3

    invoke-static {v5, p3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_2
    .catch Ljava/lang/NoSuchMethodError; {:try_start_2 .. :try_end_2} :catch_1
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_4

    .line 554
    :cond_c
    const-string p0, "Permissions automatically granted"

    invoke-static {v5, p0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    return v2

    :catch_0
    move-exception p0

    .line 551
    invoke-virtual {p0}, Ljava/lang/Exception;->printStackTrace()V

    return v1

    :catch_1
    move-exception p0

    .line 547
    invoke-virtual {p0}, Ljava/lang/NoSuchMethodError;->printStackTrace()V

    return v1
.end method

.method public static autoGrantStoragePermission(Landroid/content/Context;)Z
    .locals 8

    .line 444
    const-string v0, "android.permission.WRITE_EXTERNAL_STORAGE"

    const-string v1, "android.permission.MANAGE_EXTERNAL_STORAGE"

    const/4 v2, 0x0

    :try_start_0
    const-string v3, "device_policy"

    invoke-virtual {p0, v3}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/app/admin/DevicePolicyManager;

    .line 446
    invoke-static {p0}, Lcom/hmdm/launcher/util/LegacyUtils;->getAdminComponentName(Landroid/content/Context;)Landroid/content/ComponentName;

    move-result-object v4

    .line 448
    sget v5, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v6, 0x1d

    const/4 v7, 0x1

    if-ge v5, v6, :cond_0

    .line 450
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    .line 449
    invoke-virtual {v3, v4, v1, v0}, Landroid/app/admin/DevicePolicyManager;->getPermissionGrantState(Landroid/content/ComponentName;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    if-eq v1, v7, :cond_1

    .line 452
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object p0

    .line 451
    invoke-virtual {v3, v4, p0, v0, v7}, Landroid/app/admin/DevicePolicyManager;->setPermissionGrantState(Landroid/content/ComponentName;Ljava/lang/String;Ljava/lang/String;I)Z

    move-result p0

    if-nez p0, :cond_1

    return v2

    .line 459
    :cond_0
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v0

    .line 458
    invoke-virtual {v3, v4, v0, v1}, Landroid/app/admin/DevicePolicyManager;->getPermissionGrantState(Landroid/content/ComponentName;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    if-eq v0, v7, :cond_1

    .line 461
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object p0

    .line 460
    invoke-virtual {v3, v4, p0, v1, v7}, Landroid/app/admin/DevicePolicyManager;->setPermissionGrantState(Landroid/content/ComponentName;Ljava/lang/String;Ljava/lang/String;I)Z

    move-result p0
    :try_end_0
    .catch Ljava/lang/NoSuchMethodError; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    if-nez p0, :cond_1

    return v2

    .line 476
    :cond_1
    const-string p0, "HeadwindMDM"

    const-string v0, "MANAGE_EXTERNAL_STORAGE automatically granted"

    invoke-static {p0, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    return v7

    :catch_0
    move-exception p0

    .line 473
    invoke-virtual {p0}, Ljava/lang/Exception;->printStackTrace()V

    return v2

    :catch_1
    move-exception p0

    .line 469
    invoke-virtual {p0}, Ljava/lang/NoSuchMethodError;->printStackTrace()V

    return v2
.end method

.method public static canDrawOverlays(Landroid/content/Context;)Z
    .locals 0

    .line 714
    invoke-static {p0}, Landroid/provider/Settings;->canDrawOverlays(Landroid/content/Context;)Z

    move-result p0

    if-eqz p0, :cond_0

    const/4 p0, 0x1

    return p0

    :cond_0
    const/4 p0, 0x0

    return p0
.end method

.method public static canInstallPackages(Landroid/content/Context;)Z
    .locals 1

    .line 697
    sget-object v0, Lcom/hmdm/launcher/BuildConfig;->SYSTEM_PRIVILEGES:Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 p0, 0x1

    return p0

    .line 708
    :cond_0
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object p0

    invoke-virtual {p0}, Landroid/content/pm/PackageManager;->canRequestPackageInstalls()Z

    move-result p0

    return p0
.end method

.method public static checkAdminMode(Landroid/content/Context;)Z
    .locals 1

    .line 719
    :try_start_0
    const-string v0, "device_policy"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/admin/DevicePolicyManager;

    .line 720
    invoke-static {p0}, Lcom/hmdm/launcher/util/LegacyUtils;->getAdminComponentName(Landroid/content/Context;)Landroid/content/ComponentName;

    move-result-object p0

    .line 721
    invoke-virtual {v0, p0}, Landroid/app/admin/DevicePolicyManager;->isAdminActive(Landroid/content/ComponentName;)Z

    move-result p0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return p0

    :catch_0
    const/4 p0, 0x1

    return p0
.end method

.method public static clearDefaultLauncher(Landroid/content/Context;)V
    .locals 3

    .line 1204
    new-instance v0, Landroid/content/IntentFilter;

    const-string v1, "android.intent.action.MAIN"

    invoke-direct {v0, v1}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    .line 1205
    const-string v1, "android.intent.category.HOME"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addCategory(Ljava/lang/String;)V

    .line 1206
    const-string v1, "android.intent.category.DEFAULT"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addCategory(Ljava/lang/String;)V

    const/4 v1, 0x0

    .line 1208
    const-string v2, "Reset default launcher"

    invoke-static {p0, v0, v1, v2}, Lcom/hmdm/launcher/util/Utils;->setPreferredActivity(Landroid/content/Context;Landroid/content/IntentFilter;Landroid/content/ComponentName;Ljava/lang/String;)V

    return-void
.end method

.method public static disableScreenshots(Ljava/lang/Boolean;Landroid/content/Context;)Z
    .locals 2

    .line 1027
    invoke-static {p1}, Lcom/hmdm/launcher/util/Utils;->isDeviceOwner(Landroid/content/Context;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    .line 1031
    const-string v0, "device_policy"

    invoke-virtual {p1, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/admin/DevicePolicyManager;

    .line 1033
    invoke-static {p1}, Lcom/hmdm/launcher/util/LegacyUtils;->getAdminComponentName(Landroid/content/Context;)Landroid/content/ComponentName;

    move-result-object p1

    .line 1036
    :try_start_0
    invoke-virtual {p0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p0

    invoke-virtual {v0, p1, p0}, Landroid/app/admin/DevicePolicyManager;->setScreenCaptureDisabled(Landroid/content/ComponentName;Z)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const/4 p0, 0x1

    return p0

    :catch_0
    move-exception p0

    .line 1038
    invoke-virtual {p0}, Ljava/lang/Exception;->printStackTrace()V

    :cond_0
    return v1
.end method

.method public static factoryReset(Landroid/content/Context;)Z
    .locals 3

    const/4 v0, 0x0

    .line 732
    :try_start_0
    const-string v1, "device_policy"

    invoke-virtual {p0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/app/admin/DevicePolicyManager;

    .line 733
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x22

    if-ge v1, v2, :cond_0

    .line 734
    invoke-virtual {p0, v0}, Landroid/app/admin/DevicePolicyManager;->wipeData(I)V

    goto :goto_0

    .line 736
    :cond_0
    invoke-virtual {p0, v0}, Landroid/app/admin/DevicePolicyManager;->wipeDevice(I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    const/4 p0, 0x1

    return p0

    :catch_0
    return v0
.end method

.method public static forceLocationOn(Landroid/content/Context;)V
    .locals 5

    .line 234
    invoke-static {p0}, Lcom/hmdm/launcher/util/Utils;->isDeviceOwner(Landroid/content/Context;)Z

    move-result v0

    if-eqz v0, :cond_2

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1e

    if-ge v0, v1, :cond_0

    goto :goto_0

    .line 238
    :cond_0
    :try_start_0
    const-string v0, "device_policy"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/admin/DevicePolicyManager;

    .line 239
    invoke-static {p0}, Lcom/hmdm/launcher/util/LegacyUtils;->getAdminComponentName(Landroid/content/Context;)Landroid/content/ComponentName;

    move-result-object v1

    if-eqz v0, :cond_2

    if-nez v1, :cond_1

    goto :goto_0

    :cond_1
    const/4 v2, 0x1

    .line 243
    invoke-virtual {v0, v1, v2}, Landroid/app/admin/DevicePolicyManager;->setLocationEnabled(Landroid/content/ComponentName;Z)V

    .line 244
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v3

    const-string v4, "android.permission.ACCESS_FINE_LOCATION"

    invoke-virtual {v0, v1, v3, v4, v2}, Landroid/app/admin/DevicePolicyManager;->setPermissionGrantState(Landroid/content/ComponentName;Ljava/lang/String;Ljava/lang/String;I)Z

    .line 246
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v3

    const-string v4, "android.permission.ACCESS_COARSE_LOCATION"

    invoke-virtual {v0, v1, v3, v4, v2}, Landroid/app/admin/DevicePolicyManager;->setPermissionGrantState(Landroid/content/ComponentName;Ljava/lang/String;Ljava/lang/String;I)Z

    .line 248
    sget v3, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v4, 0x1d

    if-lt v3, v4, :cond_2

    .line 249
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object p0

    const-string v3, "android.permission.ACCESS_BACKGROUND_LOCATION"

    invoke-virtual {v0, v1, p0, v3, v2}, Landroid/app/admin/DevicePolicyManager;->setPermissionGrantState(Landroid/content/ComponentName;Ljava/lang/String;Ljava/lang/String;I)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p0

    .line 253
    invoke-virtual {p0}, Ljava/lang/Exception;->printStackTrace()V

    :cond_2
    :goto_0
    return-void
.end method

.method private static getDataToken(Landroid/content/Context;)Ljava/lang/String;
    .locals 5

    .line 759
    const-string v0, "PREFERENCES"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v2

    const/4 v3, 0x0

    const-string v4, "PREFERENCES_DATA_TOKEN"

    invoke-interface {v2, v4, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    if-nez v2, :cond_0

    .line 761
    invoke-static {}, Ljava/util/UUID;->randomUUID()Ljava/util/UUID;

    move-result-object v2

    invoke-virtual {v2}, Ljava/util/UUID;->toString()Ljava/lang/String;

    move-result-object v2

    .line 762
    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p0

    .line 763
    invoke-interface {p0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p0

    .line 764
    invoke-interface {p0, v4, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object p0

    .line 765
    invoke-interface {p0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    :cond_0
    return-object v2
.end method

.method public static getDefaultLauncher(Landroid/content/Context;)Ljava/lang/String;
    .locals 0

    .line 1151
    invoke-static {p0}, Lcom/hmdm/launcher/util/Utils;->getDefaultLauncherInfo(Landroid/content/Context;)Landroid/content/pm/ActivityInfo;

    move-result-object p0

    if-eqz p0, :cond_0

    .line 1153
    iget-object p0, p0, Landroid/content/pm/ActivityInfo;->packageName:Ljava/lang/String;

    return-object p0

    :cond_0
    const/4 p0, 0x0

    return-object p0
.end method

.method public static getDefaultLauncherInfo(Landroid/content/Context;)Landroid/content/pm/ActivityInfo;
    .locals 2

    .line 1160
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object p0

    .line 1161
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.MAIN"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 1162
    const-string v1, "android.intent.category.HOME"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    const/high16 v1, 0x10000

    .line 1163
    invoke-virtual {p0, v0, v1}, Landroid/content/pm/PackageManager;->resolveActivity(Landroid/content/Intent;I)Landroid/content/pm/ResolveInfo;

    move-result-object p0

    if-eqz p0, :cond_1

    .line 1165
    iget-object v0, p0, Landroid/content/pm/ResolveInfo;->activityInfo:Landroid/content/pm/ActivityInfo;

    if-nez v0, :cond_0

    goto :goto_0

    .line 1168
    :cond_0
    iget-object p0, p0, Landroid/content/pm/ResolveInfo;->activityInfo:Landroid/content/pm/ActivityInfo;

    return-object p0

    :cond_1
    :goto_0
    const/4 p0, 0x0

    return-object p0
.end method

.method private static getForegroundPackage(Landroid/content/Context;)Ljava/lang/String;
    .locals 9

    .line 358
    const-string v0, "unknown"

    .line 361
    :try_start_0
    const-string v1, "usagestats"

    .line 362
    invoke-virtual {p0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    move-object v1, p0

    check-cast v1, Landroid/app/usage/UsageStatsManager;

    if-nez v1, :cond_0

    return-object v0

    .line 366
    :cond_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v5

    const-wide/32 v2, 0x36ee80

    sub-long v3, v5, v2

    const/4 v2, 0x0

    .line 367
    invoke-virtual/range {v1 .. v6}, Landroid/app/usage/UsageStatsManager;->queryUsageStats(IJJ)Ljava/util/List;

    move-result-object p0

    if-eqz p0, :cond_5

    .line 369
    invoke-interface {p0}, Ljava/util/List;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_1

    goto :goto_1

    .line 374
    :cond_1
    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p0

    const/4 v1, 0x0

    const-wide/16 v2, 0x0

    :cond_2
    :goto_0
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_3

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/app/usage/UsageStats;

    .line 375
    invoke-virtual {v4}, Landroid/app/usage/UsageStats;->getLastTimeUsed()J

    move-result-wide v5

    cmp-long v5, v5, v2

    if-lez v5, :cond_2

    .line 376
    invoke-virtual {v4}, Landroid/app/usage/UsageStats;->getLastTimeUsed()J

    move-result-wide v1

    .line 377
    invoke-virtual {v4}, Landroid/app/usage/UsageStats;->getPackageName()Ljava/lang/String;

    move-result-object v3

    move-wide v7, v1

    move-object v1, v3

    move-wide v2, v7

    goto :goto_0

    :cond_3
    if-eqz v1, :cond_4

    return-object v1

    :cond_4
    return-object v0

    .line 370
    :cond_5
    :goto_1
    const-string p0, "unknown(no usage access)"
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :catch_0
    return-object v0
.end method

.method public static getLauncherVariant()Ljava/lang/String;
    .locals 2

    .line 388
    const-string v0, ""

    const-string v1, "opensource"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    return-object v1
.end method

.method private static getMinutesFromString(Ljava/lang/String;)I
    .locals 3

    const/4 v0, 0x0

    const/4 v1, 0x2

    .line 686
    :try_start_0
    invoke-virtual {p0, v0, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x3

    const/4 v2, 0x5

    .line 687
    invoke-virtual {p0, v1, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p0

    .line 688
    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    .line 689
    invoke-static {p0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result p0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    mul-int/lit8 v0, v0, 0x3c

    add-int/2addr v0, p0

    return v0

    :catch_0
    const/4 p0, -0x1

    return p0
.end method

.method private static getRuntimePermissions(Landroid/content/pm/PackageManager;Ljava/lang/String;)Ljava/util/List;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/pm/PackageManager;",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 565
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    const/16 v1, 0x1000

    .line 569
    :try_start_0
    invoke-virtual {p0, p1, v1}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object p1
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz p1, :cond_3

    .line 575
    iget-object v1, p1, Landroid/content/pm/PackageInfo;->requestedPermissions:[Ljava/lang/String;

    if-eqz v1, :cond_3

    .line 576
    iget-object p1, p1, Landroid/content/pm/PackageInfo;->requestedPermissions:[Ljava/lang/String;

    array-length v1, p1

    const/4 v2, 0x0

    move v3, v2

    :goto_0
    if-ge v2, v1, :cond_2

    aget-object v4, p1, v2

    .line 577
    const-string v5, "android.permission.MANAGE_EXTERNAL_STORAGE"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_0

    const/4 v3, 0x1

    .line 580
    :cond_0
    invoke-static {p0, v4}, Lcom/hmdm/launcher/util/Utils;->isRuntimePermission(Landroid/content/pm/PackageManager;Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_1

    .line 581
    invoke-interface {v0, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_2
    if-eqz v3, :cond_3

    .line 589
    new-instance p0, Lcom/hmdm/launcher/util/Utils$$ExternalSyntheticLambda0;

    invoke-direct {p0}, Lcom/hmdm/launcher/util/Utils$$ExternalSyntheticLambda0;-><init>()V

    invoke-interface {v0, p0}, Ljava/util/List;->removeIf(Ljava/util/function/Predicate;)Z

    :catch_0
    :cond_3
    return-object v0
.end method

.method public static grantRemoteAccessPermissions(Landroid/content/Context;Ljava/lang/String;)V
    .locals 7

    if-eqz p1, :cond_3

    .line 265
    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_3

    .line 266
    invoke-static {p0}, Lcom/hmdm/launcher/util/Utils;->isDeviceOwner(Landroid/content/Context;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 267
    invoke-static {p0, p1}, Lcom/hmdm/launcher/util/Utils;->isPackageInstalled(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_1

    .line 271
    :cond_0
    :try_start_0
    const-string v0, "device_policy"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/admin/DevicePolicyManager;

    .line 272
    invoke-static {p0}, Lcom/hmdm/launcher/util/LegacyUtils;->getAdminComponentName(Landroid/content/Context;)Landroid/content/ComponentName;

    move-result-object p0

    if-eqz v0, :cond_3

    if-nez p0, :cond_1

    goto :goto_1

    :cond_1
    const/4 v1, 0x5

    .line 276
    new-array v2, v1, [Ljava/lang/String;

    const-string v3, "android.permission.READ_EXTERNAL_STORAGE"

    const/4 v4, 0x0

    aput-object v3, v2, v4

    const-string v3, "android.permission.WRITE_EXTERNAL_STORAGE"

    const/4 v5, 0x1

    aput-object v3, v2, v5

    const-string v3, "android.permission.RECORD_AUDIO"

    const/4 v6, 0x2

    aput-object v3, v2, v6

    const-string v3, "android.permission.CAMERA"

    const/4 v6, 0x3

    aput-object v3, v2, v6

    const-string v3, "android.permission.ACCESS_FINE_LOCATION"

    const/4 v6, 0x4

    aput-object v3, v2, v6

    :goto_0
    if-ge v4, v1, :cond_2

    .line 283
    aget-object v3, v2, v4
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    .line 285
    :try_start_1
    invoke-virtual {v0, p0, p1, v3, v5}, Landroid/app/admin/DevicePolicyManager;->setPermissionGrantState(Landroid/content/ComponentName;Ljava/lang/String;Ljava/lang/String;I)Z
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    .line 290
    :cond_2
    :try_start_2
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1

    const/16 v2, 0x21

    if-lt v1, v2, :cond_3

    .line 292
    :try_start_3
    const-string v1, "android.permission.POST_NOTIFICATIONS"

    invoke-virtual {v0, p0, p1, v1, v5}, Landroid/app/admin/DevicePolicyManager;->setPermissionGrantState(Landroid/content/ComponentName;Ljava/lang/String;Ljava/lang/String;I)Z
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_2

    goto :goto_1

    :catch_1
    move-exception p0

    .line 298
    invoke-virtual {p0}, Ljava/lang/Exception;->printStackTrace()V

    :catch_2
    :cond_3
    :goto_1
    return-void
.end method

.method public static initPasswordReset(Landroid/content/Context;)V
    .locals 4

    .line 773
    :try_start_0
    const-string v0, "device_policy"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/admin/DevicePolicyManager;

    .line 774
    invoke-static {p0}, Lcom/hmdm/launcher/util/LegacyUtils;->getAdminComponentName(Landroid/content/Context;)Landroid/content/ComponentName;

    move-result-object v1

    .line 780
    invoke-virtual {v0, v1}, Landroid/app/admin/DevicePolicyManager;->isResetPasswordTokenActive(Landroid/content/ComponentName;)Z

    move-result v2
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    if-eqz v2, :cond_0

    goto :goto_0

    .line 786
    :cond_0
    :try_start_1
    invoke-virtual {v0, v1}, Landroid/app/admin/DevicePolicyManager;->clearResetPasswordToken(Landroid/content/ComponentName;)Z
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    .line 790
    :catch_0
    :try_start_2
    invoke-static {p0}, Lcom/hmdm/launcher/util/Utils;->getDataToken(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v2

    .line 791
    invoke-virtual {v2}, Ljava/lang/String;->getBytes()[B

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/app/admin/DevicePolicyManager;->setResetPasswordToken(Landroid/content/ComponentName;[B)Z

    move-result v2

    const/4 v3, 0x2

    if-eqz v2, :cond_1

    .line 792
    invoke-virtual {v0, v1}, Landroid/app/admin/DevicePolicyManager;->isResetPasswordTokenActive(Landroid/content/ComponentName;)Z

    move-result v0

    if-nez v0, :cond_2

    .line 793
    const-string v0, "Password reset token will be activated once the user enters the current password next time."

    invoke-static {p0, v3, v0}, Lcom/hmdm/launcher/util/RemoteLogger;->log(Landroid/content/Context;ILjava/lang/String;)V

    goto :goto_0

    .line 796
    :cond_1
    const-string v0, "Failed to setup password reset token, password reset requests will fail"

    invoke-static {p0, v3, v0}, Lcom/hmdm/launcher/util/RemoteLogger;->log(Landroid/content/Context;ILjava/lang/String;)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_0

    :catch_1
    move-exception p0

    .line 799
    invoke-virtual {p0}, Ljava/lang/Exception;->printStackTrace()V

    :cond_2
    :goto_0
    return-void
.end method

.method public static isDeviceOwner(Landroid/content/Context;)Z
    .locals 1

    .line 77
    const-string v0, "device_policy"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/admin/DevicePolicyManager;

    if-eqz v0, :cond_0

    .line 78
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Landroid/app/admin/DevicePolicyManager;->isDeviceOwnerApp(Ljava/lang/String;)Z

    move-result p0

    if-eqz p0, :cond_0

    const/4 p0, 0x1

    return p0

    :cond_0
    const/4 p0, 0x0

    return p0
.end method

.method public static isLauncherIntent(Landroid/content/Intent;)Z
    .locals 3

    const/4 v0, 0x0

    if-nez p0, :cond_0

    return v0

    .line 1138
    :cond_0
    invoke-virtual {p0}, Landroid/content/Intent;->getCategories()Ljava/util/Set;

    move-result-object p0

    if-nez p0, :cond_1

    return v0

    .line 1142
    :cond_1
    invoke-interface {p0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :cond_2
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_3

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 1143
    const-string v2, "android.intent.category.LAUNCHER"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    const/4 p0, 0x1

    return p0

    :cond_3
    return v0
.end method

.method public static isLightColor(I)Z
    .locals 3

    .line 621
    invoke-static {p0}, Landroid/graphics/Color;->red(I)I

    move-result v0

    .line 622
    invoke-static {p0}, Landroid/graphics/Color;->green(I)I

    move-result v1

    .line 623
    invoke-static {p0}, Landroid/graphics/Color;->blue(I)I

    move-result p0

    const/16 v2, 0xa0

    if-lt v0, v2, :cond_0

    if-lt v1, v2, :cond_0

    if-lt p0, v2, :cond_0

    const/4 p0, 0x1

    return p0

    :cond_0
    const/4 p0, 0x0

    return p0
.end method

.method public static isLocationPermission(Ljava/lang/String;)Z
    .locals 1

    .line 559
    const-string v0, "android.permission.ACCESS_COARSE_LOCATION"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    const-string v0, "android.permission.ACCESS_FINE_LOCATION"

    .line 560
    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    const-string v0, "android.permission.ACCESS_BACKGROUND_LOCATION"

    .line 561
    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_0

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    return p0

    :cond_1
    :goto_0
    const/4 p0, 0x1

    return p0
.end method

.method public static isMiui(Landroid/content/Context;)Z
    .locals 1

    .line 850
    const-string v0, "com.miui.home"

    invoke-static {p0, v0}, Lcom/hmdm/launcher/util/Utils;->isPackageInstalled(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    const-string v0, "com.miui.securitycenter"

    .line 851
    invoke-static {p0, v0}, Lcom/hmdm/launcher/util/Utils;->isPackageInstalled(Landroid/content/Context;Ljava/lang/String;)Z

    move-result p0

    if-eqz p0, :cond_0

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    return p0

    :cond_1
    :goto_0
    const/4 p0, 0x1

    return p0
.end method

.method public static isMobileDataEnabled(Landroid/content/Context;)Z
    .locals 5

    .line 823
    const-string v0, "connectivity"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/net/ConnectivityManager;

    const/4 v0, 0x1

    .line 827
    :try_start_0
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1

    .line 828
    const-string v2, "getMobileDataEnabled"

    const/4 v3, 0x0

    new-array v4, v3, [Ljava/lang/Class;

    invoke-virtual {v1, v2, v4}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 829
    invoke-virtual {v1, v0}, Ljava/lang/reflect/Method;->setAccessible(Z)V

    .line 831
    new-array v2, v3, [Ljava/lang/Object;

    invoke-virtual {v1, p0, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Ljava/lang/Boolean;

    invoke-virtual {p0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return p0

    :catch_0
    return v0
.end method

.method public static isPackageInstalled(Landroid/content/Context;Ljava/lang/String;)Z
    .locals 1

    .line 840
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object p0

    const/16 v0, 0x80

    .line 842
    :try_start_0
    invoke-virtual {p0, p1, v0}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    const/4 p0, 0x1

    return p0

    :catch_0
    const/4 p0, 0x0

    return p0
.end method

.method private static isRuntimePermission(Landroid/content/pm/PackageManager;Ljava/lang/String;)Z
    .locals 1

    const/4 v0, 0x0

    .line 598
    :try_start_0
    invoke-virtual {p0, p1, v0}, Landroid/content/pm/PackageManager;->getPermissionInfo(Ljava/lang/String;I)Landroid/content/pm/PermissionInfo;

    move-result-object p0

    if-eqz p0, :cond_0

    .line 600
    iget p0, p0, Landroid/content/pm/PermissionInfo;->protectionLevel:I
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    and-int/lit8 p0, p0, 0xf

    const/4 p1, 0x1

    if-ne p0, p1, :cond_0

    return p1

    :catch_0
    :cond_0
    return v0
.end method

.method public static isServiceRunning(Landroid/content/Context;Ljava/lang/Class;)Z
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/lang/Class<",
            "*>;)Z"
        }
    .end annotation

    const/4 v0, 0x0

    .line 1173
    :try_start_0
    const-string v1, "activity"

    invoke-virtual {p0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/app/ActivityManager;

    const v1, 0x7fffffff

    .line 1174
    invoke-virtual {p0, v1}, Landroid/app/ActivityManager;->getRunningServices(I)Ljava/util/List;

    move-result-object p0

    .line 1175
    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :cond_0
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/app/ActivityManager$RunningServiceInfo;

    .line 1176
    invoke-virtual {p1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    iget-object v1, v1, Landroid/app/ActivityManager$RunningServiceInfo;->service:Landroid/content/ComponentName;

    invoke-virtual {v1}, Landroid/content/ComponentName;->getClassName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v1, :cond_0

    const/4 p0, 0x1

    return p0

    :catch_0
    :cond_1
    return v0
.end method

.method static synthetic lambda$getRuntimePermissions$0(Ljava/lang/String;)Z
    .locals 1

    .line 589
    const-string v0, "android.permission.WRITE_EXTERNAL_STORAGE"

    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    const-string v0, "android.permission.READ_EXTERNAL_STORAGE"

    .line 590
    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_0

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    return p0

    :cond_1
    :goto_0
    const/4 p0, 0x1

    return p0
.end method

.method public static loadFileAsString(Ljava/lang/String;)Ljava/lang/String;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1383
    new-instance v0, Ljava/lang/StringBuffer;

    invoke-direct {v0}, Ljava/lang/StringBuffer;-><init>()V

    .line 1384
    new-instance v1, Ljava/io/BufferedReader;

    new-instance v2, Ljava/io/FileReader;

    invoke-direct {v2, p0}, Ljava/io/FileReader;-><init>(Ljava/lang/String;)V

    invoke-direct {v1, v2}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    const/16 p0, 0x400

    .line 1385
    new-array p0, p0, [C

    .line 1387
    :goto_0
    invoke-virtual {v1, p0}, Ljava/io/BufferedReader;->read([C)I

    move-result v2

    const/4 v3, -0x1

    if-eq v2, v3, :cond_0

    const/4 v3, 0x0

    .line 1388
    invoke-static {p0, v3, v2}, Ljava/lang/String;->valueOf([CII)Ljava/lang/String;

    move-result-object v2

    .line 1389
    invoke-virtual {v0, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    goto :goto_0

    .line 1391
    :cond_0
    invoke-virtual {v1}, Ljava/io/BufferedReader;->close()V

    .line 1392
    invoke-virtual {v0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static loadStreamAsString(Ljava/io/InputStreamReader;)Ljava/lang/String;
    .locals 4

    const/4 v0, 0x0

    .line 1402
    :try_start_0
    new-instance v1, Ljava/io/BufferedReader;

    invoke-direct {v1, p0}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_2
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1403
    :try_start_1
    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    .line 1405
    :goto_0
    invoke-virtual {v1}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_0

    .line 1406
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\n"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_0

    .line 1408
    :cond_0
    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 1415
    :try_start_2
    invoke-virtual {v1}, Ljava/io/BufferedReader;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0

    return-object p0

    :catch_0
    move-exception v0

    .line 1417
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    return-object p0

    :catch_1
    move-exception p0

    goto :goto_1

    :catchall_0
    move-exception p0

    goto :goto_3

    :catch_2
    move-exception p0

    move-object v1, v0

    .line 1410
    :goto_1
    :try_start_3
    invoke-virtual {p0}, Ljava/io/IOException;->printStackTrace()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    if-eqz v1, :cond_1

    .line 1415
    :try_start_4
    invoke-virtual {v1}, Ljava/io/BufferedReader;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_3

    goto :goto_2

    :catch_3
    move-exception p0

    .line 1417
    invoke-virtual {p0}, Ljava/io/IOException;->printStackTrace()V

    :cond_1
    :goto_2
    return-object v0

    :catchall_1
    move-exception p0

    move-object v0, v1

    :goto_3
    if-eqz v0, :cond_2

    .line 1415
    :try_start_5
    invoke-virtual {v0}, Ljava/io/BufferedReader;->close()V
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_4

    goto :goto_4

    :catch_4
    move-exception v0

    .line 1417
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    .line 1420
    :cond_2
    :goto_4
    throw p0
.end method

.method public static lockPackages(Landroid/content/Context;Ljava/lang/String;Z)V
    .locals 4

    if-eqz p1, :cond_0

    .line 1474
    invoke-static {p0}, Lcom/hmdm/launcher/util/Utils;->isDeviceOwner(Landroid/content/Context;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 1476
    invoke-static {p0}, Lcom/hmdm/launcher/util/LegacyUtils;->getAdminComponentName(Landroid/content/Context;)Landroid/content/ComponentName;

    move-result-object v0

    .line 1477
    const-string v1, "device_policy"

    invoke-virtual {p0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/app/admin/DevicePolicyManager;

    .line 1478
    const-string v1, " "

    const-string v2, ""

    invoke-virtual {p1, v1, v2}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    .line 1479
    const-string v1, ","

    invoke-virtual {p1, v1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object p1

    .line 1482
    :try_start_0
    invoke-virtual {p0, v0, p1, p2}, Landroid/app/admin/DevicePolicyManager;->setPackagesSuspended(Landroid/content/ComponentName;[Ljava/lang/String;Z)[Ljava/lang/String;

    .line 1484
    array-length v1, p1

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_0

    aget-object v3, p1, v2

    .line 1485
    invoke-virtual {p0, v0, v3, p2}, Landroid/app/admin/DevicePolicyManager;->setApplicationHidden(Landroid/content/ComponentName;Ljava/lang/String;Z)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :catch_0
    move-exception p0

    .line 1488
    invoke-virtual {p0}, Ljava/lang/Exception;->printStackTrace()V

    :cond_0
    return-void
.end method

.method public static lockSafeBoot(Landroid/content/Context;)Z
    .locals 3

    .line 855
    invoke-static {p0}, Lcom/hmdm/launcher/util/Utils;->isDeviceOwner(Landroid/content/Context;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    .line 859
    const-string v0, "device_policy"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/admin/DevicePolicyManager;

    .line 861
    invoke-static {p0}, Lcom/hmdm/launcher/util/LegacyUtils;->getAdminComponentName(Landroid/content/Context;)Landroid/content/ComponentName;

    move-result-object p0

    .line 864
    :try_start_0
    const-string v2, "no_safe_boot"

    invoke-virtual {v0, p0, v2}, Landroid/app/admin/DevicePolicyManager;->addUserRestriction(Landroid/content/ComponentName;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const/4 p0, 0x1

    return p0

    :catch_0
    move-exception p0

    .line 866
    invoke-virtual {p0}, Ljava/lang/Exception;->printStackTrace()V

    :cond_0
    return v1
.end method

.method public static lockUsbStorage(ZLandroid/content/Context;)Z
    .locals 5

    .line 873
    invoke-static {p1}, Lcom/hmdm/launcher/util/Utils;->isDeviceOwner(Landroid/content/Context;)Z

    move-result v0

    const/4 v1, 0x1

    const/4 v2, 0x0

    if-eqz v0, :cond_1

    .line 887
    const-string v0, "device_policy"

    invoke-virtual {p1, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/admin/DevicePolicyManager;

    .line 889
    invoke-static {p1}, Lcom/hmdm/launcher/util/LegacyUtils;->getAdminComponentName(Landroid/content/Context;)Landroid/content/ComponentName;

    move-result-object p1

    .line 892
    const-string v3, "no_physical_media"

    const-string v4, "no_usb_file_transfer"

    if-eqz p0, :cond_0

    .line 893
    :try_start_0
    invoke-virtual {v0, p1, v4}, Landroid/app/admin/DevicePolicyManager;->addUserRestriction(Landroid/content/ComponentName;Ljava/lang/String;)V

    .line 894
    invoke-virtual {v0, p1, v3}, Landroid/app/admin/DevicePolicyManager;->addUserRestriction(Landroid/content/ComponentName;Ljava/lang/String;)V

    goto :goto_0

    .line 896
    :cond_0
    invoke-virtual {v0, p1, v4}, Landroid/app/admin/DevicePolicyManager;->clearUserRestriction(Landroid/content/ComponentName;Ljava/lang/String;)V

    .line 897
    invoke-virtual {v0, p1, v3}, Landroid/app/admin/DevicePolicyManager;->clearUserRestriction(Landroid/content/ComponentName;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return v1

    :catch_0
    move-exception p0

    .line 900
    invoke-virtual {p0}, Ljava/lang/Exception;->printStackTrace()V

    return v2

    .line 879
    :cond_1
    :try_start_1
    invoke-virtual {p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object p0

    const-string p1, "usb_mass_storage_enabled"

    invoke-static {p0, p1, v2}, Landroid/provider/Settings$Global;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    return v1

    :catch_1
    return v2
.end method

.method public static lockUserRestrictions(Landroid/content/Context;Ljava/lang/String;)V
    .locals 4

    .line 1319
    invoke-static {p0}, Lcom/hmdm/launcher/util/LegacyUtils;->getAdminComponentName(Landroid/content/Context;)Landroid/content/ComponentName;

    move-result-object v0

    .line 1320
    const-string v1, "device_policy"

    invoke-virtual {p0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/app/admin/DevicePolicyManager;

    if-eqz v1, :cond_1

    .line 1321
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v1, p0}, Landroid/app/admin/DevicePolicyManager;->isDeviceOwnerApp(Ljava/lang/String;)Z

    move-result p0

    if-nez p0, :cond_0

    goto :goto_1

    .line 1325
    :cond_0
    const-string p0, ","

    invoke-virtual {p1, p0}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object p0

    .line 1326
    array-length p1, p0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, p1, :cond_1

    aget-object v3, p0, v2

    .line 1328
    :try_start_0
    invoke-virtual {v3}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v0, v3}, Landroid/app/admin/DevicePolicyManager;->addUserRestriction(Landroid/content/ComponentName;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_1
    :goto_1
    return-void
.end method

.method public static lockVolume(Ljava/lang/Boolean;Landroid/content/Context;)Z
    .locals 4

    .line 970
    invoke-static {p1}, Lcom/hmdm/launcher/util/Utils;->isDeviceOwner(Landroid/content/Context;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_2

    .line 974
    const-string v0, "device_policy"

    invoke-virtual {p1, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/admin/DevicePolicyManager;

    .line 976
    invoke-static {p1}, Lcom/hmdm/launcher/util/LegacyUtils;->getAdminComponentName(Landroid/content/Context;)Landroid/content/ComponentName;

    move-result-object p1

    .line 979
    const-string v2, "no_adjust_volume"

    const-string v3, "HeadwindMDM"

    if-eqz p0, :cond_1

    :try_start_0
    invoke-virtual {p0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p0

    if-nez p0, :cond_0

    goto :goto_0

    .line 983
    :cond_0
    const-string p0, "Locking volume"

    invoke-static {v3, p0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 984
    invoke-virtual {v0, p1, v2}, Landroid/app/admin/DevicePolicyManager;->addUserRestriction(Landroid/content/ComponentName;Ljava/lang/String;)V

    goto :goto_1

    :catch_0
    move-exception p0

    goto :goto_2

    .line 980
    :cond_1
    :goto_0
    const-string p0, "Unlocking volume"

    invoke-static {v3, p0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 981
    invoke-virtual {v0, p1, v2}, Landroid/app/admin/DevicePolicyManager;->clearUserRestriction(Landroid/content/ComponentName;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :goto_1
    const/4 p0, 0x1

    return p0

    .line 987
    :goto_2
    new-instance p1, Ljava/lang/StringBuilder;

    const-string v0, "Failed to lock/unlock volume: "

    invoke-direct {p1, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {v3, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 988
    invoke-virtual {p0}, Ljava/lang/Exception;->printStackTrace()V

    :cond_2
    return v1
.end method

.method public static passwordReset(Landroid/content/Context;Ljava/lang/String;)Z
    .locals 4

    const/4 v0, 0x0

    .line 806
    :try_start_0
    const-string v1, "device_policy"

    invoke-virtual {p0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/app/admin/DevicePolicyManager;

    .line 808
    invoke-static {p0}, Lcom/hmdm/launcher/util/LegacyUtils;->getAdminComponentName(Landroid/content/Context;)Landroid/content/ComponentName;

    move-result-object v2

    .line 809
    invoke-virtual {v1, v2}, Landroid/app/admin/DevicePolicyManager;->isResetPasswordTokenActive(Landroid/content/ComponentName;)Z

    move-result v3

    if-nez v3, :cond_0

    return v0

    .line 813
    :cond_0
    invoke-static {p0}, Lcom/hmdm/launcher/util/Utils;->getDataToken(Landroid/content/Context;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/String;->getBytes()[B

    move-result-object p0

    invoke-virtual {v1, v2, p1, p0, v0}, Landroid/app/admin/DevicePolicyManager;->resetPasswordWithToken(Landroid/content/ComponentName;Ljava/lang/String;[BI)Z

    move-result p0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return p0

    :catch_0
    return v0
.end method

.method public static reboot(Landroid/content/Context;)Z
    .locals 1

    .line 749
    :try_start_0
    const-string v0, "device_policy"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/admin/DevicePolicyManager;

    .line 750
    invoke-static {p0}, Lcom/hmdm/launcher/util/LegacyUtils;->getAdminComponentName(Landroid/content/Context;)Landroid/content/ComponentName;

    move-result-object p0

    .line 751
    invoke-virtual {v0, p0}, Landroid/app/admin/DevicePolicyManager;->reboot(Landroid/content/ComponentName;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const/4 p0, 0x1

    return p0

    :catch_0
    const/4 p0, 0x0

    return p0
.end method

.method public static releaseUserRestrictions(Landroid/content/Context;Ljava/lang/String;)V
    .locals 4

    .line 1298
    invoke-static {p0}, Lcom/hmdm/launcher/util/LegacyUtils;->getAdminComponentName(Landroid/content/Context;)Landroid/content/ComponentName;

    move-result-object v0

    .line 1299
    const-string v1, "device_policy"

    invoke-virtual {p0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/app/admin/DevicePolicyManager;

    if-eqz v1, :cond_1

    .line 1300
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v1, p0}, Landroid/app/admin/DevicePolicyManager;->isDeviceOwnerApp(Ljava/lang/String;)Z

    move-result p0

    if-nez p0, :cond_0

    goto :goto_1

    .line 1304
    :cond_0
    const-string p0, ","

    invoke-virtual {p1, p0}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object p0

    .line 1305
    array-length p1, p0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, p1, :cond_1

    aget-object v3, p0, v2

    .line 1307
    :try_start_0
    invoke-virtual {v3}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v0, v3}, Landroid/app/admin/DevicePolicyManager;->clearUserRestriction(Landroid/content/ComponentName;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_1
    :goto_1
    return-void
.end method

.method public static reportPhoenixStatus(Landroid/content/Context;Ljava/lang/String;)V
    .locals 6

    const-string v0, "phoenix-status: location="

    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 333
    :try_start_0
    const-string v3, "location"

    .line 334
    invoke-virtual {p0, v3}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/location/LocationManager;

    if-eqz v3, :cond_0

    .line 335
    sget v4, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v5, 0x1c

    if-lt v4, v5, :cond_0

    .line 336
    invoke-virtual {v3}, Landroid/location/LocationManager;->isLocationEnabled()Z

    move-result v3

    goto :goto_0

    :cond_0
    if-eqz v3, :cond_2

    .line 338
    const-string v4, "gps"

    invoke-virtual {v3, v4}, Landroid/location/LocationManager;->isProviderEnabled(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_1

    const-string v4, "network"

    .line 339
    invoke-virtual {v3, v4}, Landroid/location/LocationManager;->isProviderEnabled(Ljava/lang/String;)Z

    move-result v3
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v3, :cond_2

    :cond_1
    move v3, v1

    goto :goto_0

    :catch_0
    :cond_2
    move v3, v2

    :goto_0
    if-eqz p1, :cond_3

    .line 343
    :try_start_1
    invoke-static {p0, p1}, Lcom/hmdm/launcher/util/Utils;->isPackageInstalled(Landroid/content/Context;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_3

    goto :goto_1

    :cond_3
    move v1, v2

    .line 344
    :goto_1
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    if-eqz v3, :cond_4

    .line 345
    const-string v0, "on"

    goto :goto_2

    :cond_4
    const-string v0, "off"

    :goto_2
    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, " remoteApp="

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    if-eqz v1, :cond_5

    .line 346
    const-string v0, "installed"

    goto :goto_3

    :cond_5
    const-string v0, "absent"

    :goto_3
    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, " foreground="

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    .line 347
    invoke-static {p0}, Lcom/hmdm/launcher/util/Utils;->getForegroundPackage(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const/4 v0, 0x3

    .line 344
    invoke-static {p0, v0, p1}, Lcom/hmdm/launcher/util/RemoteLogger;->log(Landroid/content/Context;ILjava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_4

    :catch_1
    move-exception p0

    .line 349
    invoke-virtual {p0}, Ljava/lang/Exception;->printStackTrace()V

    :goto_4
    return-void
.end method

.method public static resolveRemoteAccessPackage(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    .line 181
    const-string v0, "com.carriez.flutter_hbb"

    if-nez p0, :cond_0

    return-object v0

    .line 184
    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p0

    .line 185
    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_1

    return-object v0

    .line 188
    :cond_1
    const-string v0, "off"

    invoke-virtual {p0, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    const/4 p0, 0x0

    :cond_2
    return-object p0
.end method

.method public static setAction(Landroid/content/Context;Lcom/hmdm/launcher/json/Action;)V
    .locals 9

    const-string v0, "android.intent.action."

    .line 1217
    :try_start_0
    new-instance v1, Landroid/content/IntentFilter;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Lcom/hmdm/launcher/json/Action;->getAction()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    .line 1219
    invoke-virtual {p1}, Lcom/hmdm/launcher/json/Action;->getCategories()Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    const-string v2, ","

    const/4 v3, 0x0

    if-eqz v0, :cond_0

    :try_start_1
    invoke-virtual {p1}, Lcom/hmdm/launcher/json/Action;->getCategories()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_0

    .line 1220
    invoke-virtual {p1}, Lcom/hmdm/launcher/json/Action;->getCategories()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0, v2}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    .line 1221
    array-length v4, v0

    move v5, v3

    :goto_0
    if-ge v5, v4, :cond_0

    aget-object v6, v0, v5

    .line 1222
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "android.intent.category."

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v1, v6}, Landroid/content/IntentFilter;->addCategory(Ljava/lang/String;)V

    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    .line 1226
    :cond_0
    invoke-virtual {p1}, Lcom/hmdm/launcher/json/Action;->getMimeTypes()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_1

    invoke-virtual {p1}, Lcom/hmdm/launcher/json/Action;->getMimeTypes()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_1

    .line 1227
    invoke-virtual {p1}, Lcom/hmdm/launcher/json/Action;->getMimeTypes()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0, v2}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    .line 1228
    array-length v4, v0

    move v5, v3

    :goto_1
    if-ge v5, v4, :cond_1

    aget-object v6, v0, v5
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    .line 1230
    :try_start_2
    invoke-virtual {v1, v6}, Landroid/content/IntentFilter;->addDataType(Ljava/lang/String;)V
    :try_end_2
    .catch Landroid/content/IntentFilter$MalformedMimeTypeException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1

    :catch_0
    add-int/lit8 v5, v5, 0x1

    goto :goto_1

    .line 1236
    :cond_1
    :try_start_3
    invoke-virtual {p1}, Lcom/hmdm/launcher/json/Action;->getSchemes()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_5

    invoke-virtual {p1}, Lcom/hmdm/launcher/json/Action;->getSchemes()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_5

    .line 1237
    invoke-virtual {p1}, Lcom/hmdm/launcher/json/Action;->getSchemes()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0, v2}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    .line 1238
    array-length v4, v0

    move v5, v3

    :goto_2
    if-ge v5, v4, :cond_2

    aget-object v6, v0, v5

    .line 1239
    invoke-virtual {v1, v6}, Landroid/content/IntentFilter;->addDataScheme(Ljava/lang/String;)V

    add-int/lit8 v5, v5, 0x1

    goto :goto_2

    .line 1242
    :cond_2
    invoke-virtual {p1}, Lcom/hmdm/launcher/json/Action;->getHosts()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_5

    invoke-virtual {p1}, Lcom/hmdm/launcher/json/Action;->getHosts()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_5

    .line 1243
    invoke-virtual {p1}, Lcom/hmdm/launcher/json/Action;->getHosts()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0, v2}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    .line 1244
    array-length v2, v0

    move v4, v3

    :goto_3
    if-ge v4, v2, :cond_5

    aget-object v5, v0, v4

    .line 1245
    const-string v6, ":"

    invoke-virtual {v5, v6}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v5

    .line 1246
    array-length v6, v5

    const/4 v7, 0x1

    if-eq v6, v7, :cond_4

    const/4 v8, 0x2

    if-eq v6, v8, :cond_3

    goto :goto_4

    .line 1253
    :cond_3
    aget-object v6, v5, v3

    aget-object v5, v5, v7

    invoke-virtual {v1, v6, v5}, Landroid/content/IntentFilter;->addDataAuthority(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_4

    .line 1250
    :cond_4
    aget-object v5, v5, v3

    const/4 v6, 0x0

    invoke-virtual {v1, v5, v6}, Landroid/content/IntentFilter;->addDataAuthority(Ljava/lang/String;Ljava/lang/String;)V

    :goto_4
    add-int/lit8 v4, v4, 0x1

    goto :goto_3

    .line 1260
    :cond_5
    new-instance v0, Landroid/content/ComponentName;

    invoke-virtual {p1}, Lcom/hmdm/launcher/json/Action;->getPackageId()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p1}, Lcom/hmdm/launcher/json/Action;->getActivity()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v0, v2, v3}, Landroid/content/ComponentName;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 1262
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Set "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {p1}, Lcom/hmdm/launcher/json/Action;->getPackageId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "/"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {p1}, Lcom/hmdm/launcher/json/Action;->getActivity()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " as default for "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {p1}, Lcom/hmdm/launcher/json/Action;->getAction()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p0, v1, v0, p1}, Lcom/hmdm/launcher/util/Utils;->setPreferredActivity(Landroid/content/Context;Landroid/content/IntentFilter;Landroid/content/ComponentName;Ljava/lang/String;)V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_1

    goto :goto_5

    :catch_1
    move-exception p0

    .line 1265
    invoke-virtual {p0}, Ljava/lang/Exception;->printStackTrace()V

    :goto_5
    return-void
.end method

.method public static setBrightnessPolicy(Ljava/lang/Boolean;Ljava/lang/Integer;Landroid/content/Context;)Z
    .locals 5

    const-string v0, ""

    .line 907
    invoke-static {p2}, Lcom/hmdm/launcher/util/Utils;->isDeviceOwner(Landroid/content/Context;)Z

    move-result v1

    const/4 v2, 0x0

    if-eqz v1, :cond_3

    .line 911
    const-string v1, "device_policy"

    invoke-virtual {p2, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/app/admin/DevicePolicyManager;

    .line 913
    invoke-static {p2}, Lcom/hmdm/launcher/util/LegacyUtils;->getAdminComponentName(Landroid/content/Context;)Landroid/content/ComponentName;

    move-result-object p2

    .line 916
    const-string v3, "no_config_brightness"

    if-nez p0, :cond_0

    .line 918
    :try_start_0
    invoke-virtual {v1, p2, v3}, Landroid/app/admin/DevicePolicyManager;->clearUserRestriction(Landroid/content/ComponentName;Ljava/lang/String;)V

    goto :goto_0

    .line 921
    :cond_0
    invoke-virtual {v1, p2, v3}, Landroid/app/admin/DevicePolicyManager;->addUserRestriction(Landroid/content/ComponentName;Ljava/lang/String;)V

    .line 922
    sget v3, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v4, 0x1c

    if-lt v3, v4, :cond_2

    .line 924
    invoke-virtual {p0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const-string v3, "screen_brightness_mode"

    if-eqz p0, :cond_1

    .line 925
    :try_start_1
    const-string p0, "1"

    invoke-virtual {v1, p2, v3, p0}, Landroid/app/admin/DevicePolicyManager;->setSystemSetting(Landroid/content/ComponentName;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    .line 927
    :cond_1
    const-string p0, "0"

    invoke-virtual {v1, p2, v3, p0}, Landroid/app/admin/DevicePolicyManager;->setSystemSetting(Landroid/content/ComponentName;Ljava/lang/String;Ljava/lang/String;)V

    if-eqz p1, :cond_2

    .line 929
    const-string p0, "screen_brightness"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p2, p0, p1}, Landroid/app/admin/DevicePolicyManager;->setSystemSetting(Landroid/content/ComponentName;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    :cond_2
    :goto_0
    const/4 p0, 0x1

    return p0

    :catch_0
    move-exception p0

    .line 935
    invoke-virtual {p0}, Ljava/lang/Exception;->printStackTrace()V

    :cond_3
    return v2
.end method

.method public static setDefaultLauncher(Landroid/content/Context;)V
    .locals 3

    .line 1191
    new-instance v0, Landroid/content/IntentFilter;

    const-string v1, "android.intent.action.MAIN"

    invoke-direct {v0, v1}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    .line 1192
    const-string v1, "android.intent.category.HOME"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addCategory(Ljava/lang/String;)V

    .line 1193
    const-string v1, "android.intent.category.DEFAULT"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addCategory(Ljava/lang/String;)V

    .line 1195
    new-instance v1, Landroid/content/ComponentName;

    const-class v2, Lcom/hmdm/launcher/ui/MainActivity;

    invoke-direct {v1, p0, v2}, Landroid/content/ComponentName;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 1196
    const-string v2, "Set Headwind MDM as default launcher"

    invoke-static {p0, v0, v1, v2}, Lcom/hmdm/launcher/util/Utils;->setPreferredActivity(Landroid/content/Context;Landroid/content/IntentFilter;Landroid/content/ComponentName;Ljava/lang/String;)V

    return-void
.end method

.method public static setOrientation(Landroid/app/Activity;Lcom/hmdm/launcher/json/ServerConfig;)V
    .locals 2

    .line 1114
    invoke-virtual {p1}, Lcom/hmdm/launcher/json/ServerConfig;->getOrientation()Ljava/lang/Integer;

    move-result-object v0

    const/4 v1, -0x1

    if-eqz v0, :cond_2

    invoke-virtual {p1}, Lcom/hmdm/launcher/json/ServerConfig;->getOrientation()Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    if-eqz v0, :cond_2

    .line 1115
    invoke-virtual {p1}, Lcom/hmdm/launcher/json/ServerConfig;->getOrientation()Ljava/lang/Integer;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1

    const/4 v0, 0x1

    if-eq p1, v0, :cond_1

    const/4 v0, 0x2

    if-eq p1, v0, :cond_0

    .line 1125
    invoke-virtual {p0, v1}, Landroid/app/Activity;->setRequestedOrientation(I)V

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    .line 1121
    invoke-virtual {p0, p1}, Landroid/app/Activity;->setRequestedOrientation(I)V

    .line 1123
    const-string p0, "landscape"

    goto :goto_1

    .line 1117
    :cond_1
    invoke-virtual {p0, v0}, Landroid/app/Activity;->setRequestedOrientation(I)V

    .line 1119
    const-string p0, "portrait"

    goto :goto_1

    .line 1129
    :cond_2
    invoke-virtual {p0, v1}, Landroid/app/Activity;->setRequestedOrientation(I)V

    .line 1131
    :goto_0
    const-string p0, "unspecified"

    :goto_1
    const-string p1, "Set orientation: "

    invoke-virtual {p1, p0}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    const-string p1, "HeadwindMDM"

    invoke-static {p1, p0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method public static setPasswordMode(Ljava/lang/String;Landroid/content/Context;)Z
    .locals 6

    const-string v0, "Active password quality sufficient: "

    const/4 v1, 0x1

    .line 1049
    :try_start_0
    const-string v2, "device_policy"

    invoke-virtual {p1, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/app/admin/DevicePolicyManager;

    .line 1051
    invoke-static {p1}, Lcom/hmdm/launcher/util/LegacyUtils;->getAdminComponentName(Landroid/content/Context;)Landroid/content/ComponentName;

    move-result-object v3

    if-nez p0, :cond_0

    const/4 v4, 0x0

    .line 1054
    invoke-virtual {v2, v3, v4}, Landroid/app/admin/DevicePolicyManager;->setPasswordQuality(Landroid/content/ComponentName;I)V

    goto :goto_0

    .line 1055
    :cond_0
    const-string v4, "present"

    invoke-virtual {p0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    const/high16 v5, 0x20000

    if-eqz v4, :cond_1

    .line 1056
    invoke-virtual {v2, v3, v5}, Landroid/app/admin/DevicePolicyManager;->setPasswordQuality(Landroid/content/ComponentName;I)V

    .line 1057
    invoke-virtual {v2, v3, v1}, Landroid/app/admin/DevicePolicyManager;->setPasswordMinimumLength(Landroid/content/ComponentName;I)V

    goto :goto_0

    .line 1058
    :cond_1
    const-string v4, "easy"

    invoke-virtual {p0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_2

    .line 1059
    invoke-virtual {v2, v3, v5}, Landroid/app/admin/DevicePolicyManager;->setPasswordQuality(Landroid/content/ComponentName;I)V

    const/4 v4, 0x6

    .line 1060
    invoke-virtual {v2, v3, v4}, Landroid/app/admin/DevicePolicyManager;->setPasswordMinimumLength(Landroid/content/ComponentName;I)V

    goto :goto_0

    .line 1061
    :cond_2
    const-string v4, "moderate"

    invoke-virtual {p0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    const/16 v5, 0x8

    if-eqz v4, :cond_3

    const/high16 v4, 0x50000

    .line 1062
    invoke-virtual {v2, v3, v4}, Landroid/app/admin/DevicePolicyManager;->setPasswordQuality(Landroid/content/ComponentName;I)V

    .line 1063
    invoke-virtual {v2, v3, v5}, Landroid/app/admin/DevicePolicyManager;->setPasswordMinimumLength(Landroid/content/ComponentName;I)V

    goto :goto_0

    .line 1064
    :cond_3
    const-string v4, "strong"

    invoke-virtual {p0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_4

    const/high16 v4, 0x60000

    .line 1065
    invoke-virtual {v2, v3, v4}, Landroid/app/admin/DevicePolicyManager;->setPasswordQuality(Landroid/content/ComponentName;I)V

    .line 1066
    invoke-virtual {v2, v3, v1}, Landroid/app/admin/DevicePolicyManager;->setPasswordMinimumLowerCase(Landroid/content/ComponentName;I)V

    .line 1067
    invoke-virtual {v2, v3, v1}, Landroid/app/admin/DevicePolicyManager;->setPasswordMinimumUpperCase(Landroid/content/ComponentName;I)V

    .line 1068
    invoke-virtual {v2, v3, v1}, Landroid/app/admin/DevicePolicyManager;->setPasswordMinimumNumeric(Landroid/content/ComponentName;I)V

    .line 1069
    invoke-virtual {v2, v3, v1}, Landroid/app/admin/DevicePolicyManager;->setPasswordMinimumSymbols(Landroid/content/ComponentName;I)V

    .line 1070
    invoke-virtual {v2, v3, v5}, Landroid/app/admin/DevicePolicyManager;->setPasswordMinimumLength(Landroid/content/ComponentName;I)V

    .line 1072
    :cond_4
    :goto_0
    invoke-virtual {v2}, Landroid/app/admin/DevicePolicyManager;->isActivePasswordSufficient()Z

    move-result v2

    if-eqz p0, :cond_5

    .line 1074
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/4 v3, 0x4

    invoke-static {p1, v3, v0}, Lcom/hmdm/launcher/util/RemoteLogger;->log(Landroid/content/Context;ILjava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :cond_5
    return v2

    :catch_0
    move-exception v0

    .line 1078
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    if-eqz p0, :cond_6

    .line 1081
    new-instance p0, Ljava/lang/StringBuilder;

    const-string v2, "Failed to update password quality: "

    invoke-direct {p0, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    const/4 v0, 0x2

    invoke-static {p1, v0, p0}, Lcom/hmdm/launcher/util/RemoteLogger;->log(Landroid/content/Context;ILjava/lang/String;)V

    :cond_6
    return v1
.end method

.method private static setPreferredActivity(Landroid/content/Context;Landroid/content/IntentFilter;Landroid/content/ComponentName;Ljava/lang/String;)V
    .locals 2

    .line 1276
    invoke-static {p0}, Lcom/hmdm/launcher/util/LegacyUtils;->getAdminComponentName(Landroid/content/Context;)Landroid/content/ComponentName;

    move-result-object v0

    .line 1277
    const-string v1, "device_policy"

    .line 1278
    invoke-virtual {p0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/app/admin/DevicePolicyManager;

    if-eqz p2, :cond_0

    .line 1281
    :try_start_0
    invoke-virtual {v1, v0, p1, p2}, Landroid/app/admin/DevicePolicyManager;->addPersistentPreferredActivity(Landroid/content/ComponentName;Landroid/content/IntentFilter;Landroid/content/ComponentName;)V

    goto :goto_0

    .line 1283
    :cond_0
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, v0, p1}, Landroid/app/admin/DevicePolicyManager;->clearPackagePersistentPreferredActivities(Landroid/content/ComponentName;Ljava/lang/String;)V

    .line 1285
    :goto_0
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string p2, " - success"

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const/4 p2, 0x4

    invoke-static {p0, p2, p1}, Lcom/hmdm/launcher/util/RemoteLogger;->log(Landroid/content/Context;ILjava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    .line 1287
    invoke-virtual {p1}, Ljava/lang/Exception;->printStackTrace()V

    .line 1288
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    const-string p3, " - failure: "

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const/4 p2, 0x2

    invoke-static {p0, p2, p1}, Lcom/hmdm/launcher/util/RemoteLogger;->log(Landroid/content/Context;ILjava/lang/String;)V

    return-void
.end method

.method public static setProxy(Landroid/content/Context;Ljava/lang/String;)Z
    .locals 7

    const-string v0, "Invalid proxy URL: "

    .line 1358
    invoke-static {p0}, Lcom/hmdm/launcher/util/LegacyUtils;->getAdminComponentName(Landroid/content/Context;)Landroid/content/ComponentName;

    move-result-object v1

    .line 1359
    const-string v2, "device_policy"

    invoke-virtual {p0, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/app/admin/DevicePolicyManager;

    const/4 v2, 0x1

    const/4 v3, 0x0

    if-eqz p1, :cond_1

    .line 1363
    :try_start_0
    const-string v4, ":"

    invoke-virtual {p1, v4}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v4

    .line 1364
    array-length v5, v4

    const/4 v6, 0x2

    if-eq v5, v6, :cond_0

    .line 1365
    const-string p0, "HeadwindMDM"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p0, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return v3

    .line 1368
    :cond_0
    aget-object p1, v4, v2

    invoke-static {p1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result p1

    .line 1369
    aget-object v0, v4, v3

    invoke-static {v0, p1}, Landroid/net/ProxyInfo;->buildDirectProxy(Ljava/lang/String;I)Landroid/net/ProxyInfo;

    move-result-object p1

    goto :goto_0

    :cond_1
    const/4 p1, 0x0

    .line 1371
    :goto_0
    invoke-virtual {p0, v1, p1}, Landroid/app/admin/DevicePolicyManager;->setRecommendedGlobalProxy(Landroid/content/ComponentName;Landroid/net/ProxyInfo;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return v2

    :catch_0
    move-exception p0

    .line 1374
    invoke-virtual {p0}, Ljava/lang/Exception;->printStackTrace()V

    return v3
.end method

.method public static setScreenTimeoutPolicy(Ljava/lang/Boolean;Ljava/lang/Integer;Landroid/content/Context;)Z
    .locals 4

    const-string v0, ""

    .line 942
    invoke-static {p2}, Lcom/hmdm/launcher/util/Utils;->isDeviceOwner(Landroid/content/Context;)Z

    move-result v1

    const/4 v2, 0x0

    if-eqz v1, :cond_3

    .line 946
    const-string v1, "device_policy"

    invoke-virtual {p2, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/app/admin/DevicePolicyManager;

    .line 948
    invoke-static {p2}, Lcom/hmdm/launcher/util/LegacyUtils;->getAdminComponentName(Landroid/content/Context;)Landroid/content/ComponentName;

    move-result-object p2

    .line 951
    const-string v3, "no_config_screen_timeout"

    if-eqz p0, :cond_1

    :try_start_0
    invoke-virtual {p0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p0

    if-nez p0, :cond_0

    goto :goto_0

    .line 956
    :cond_0
    invoke-virtual {v1, p2, v3}, Landroid/app/admin/DevicePolicyManager;->addUserRestriction(Landroid/content/ComponentName;Ljava/lang/String;)V

    .line 957
    sget p0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0x1c

    if-lt p0, v3, :cond_2

    if-eqz p1, :cond_2

    .line 959
    const-string p0, "screen_off_timeout"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1

    mul-int/lit16 p1, p1, 0x3e8

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p2, p0, p1}, Landroid/app/admin/DevicePolicyManager;->setSystemSetting(Landroid/content/ComponentName;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_1

    :catch_0
    move-exception p0

    goto :goto_2

    .line 953
    :cond_1
    :goto_0
    invoke-virtual {v1, p2, v3}, Landroid/app/admin/DevicePolicyManager;->clearUserRestriction(Landroid/content/ComponentName;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :cond_2
    :goto_1
    const/4 p0, 0x1

    return p0

    .line 963
    :goto_2
    invoke-virtual {p0}, Ljava/lang/Exception;->printStackTrace()V

    :cond_3
    return v2
.end method

.method public static setStatusBarDisabled(Landroid/content/Context;Z)V
    .locals 1

    .line 89
    invoke-static {p0}, Lcom/hmdm/launcher/util/Utils;->isDeviceOwner(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 93
    :cond_0
    :try_start_0
    const-string v0, "device_policy"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/admin/DevicePolicyManager;

    .line 94
    invoke-static {p0}, Lcom/hmdm/launcher/util/LegacyUtils;->getAdminComponentName(Landroid/content/Context;)Landroid/content/ComponentName;

    move-result-object p0

    if-eqz v0, :cond_1

    if-eqz p0, :cond_1

    .line 96
    invoke-virtual {v0, p0, p1}, Landroid/app/admin/DevicePolicyManager;->setStatusBarDisabled(Landroid/content/ComponentName;Z)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :cond_1
    :goto_0
    return-void

    :catch_0
    move-exception p0

    .line 99
    invoke-virtual {p0}, Ljava/lang/Exception;->printStackTrace()V

    return-void
.end method

.method public static setSystemUpdatePolicy(Landroid/content/Context;ILjava/lang/String;Ljava/lang/String;)V
    .locals 7

    .line 629
    const-string v0, "Failed to set system update policy: "

    const-string v1, "HeadwindMDM"

    const-string v2, "device_policy"

    invoke-virtual {p0, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/app/admin/DevicePolicyManager;

    .line 631
    invoke-static {p0}, Lcom/hmdm/launcher/util/LegacyUtils;->getAdminComponentName(Landroid/content/Context;)Landroid/content/ComponentName;

    move-result-object p0

    .line 635
    :try_start_0
    invoke-virtual {v2}, Landroid/app/admin/DevicePolicyManager;->getSystemUpdatePolicy()Landroid/app/admin/SystemUpdatePolicy;

    move-result-object v3
    :try_end_0
    .catch Ljava/lang/NoSuchMethodError; {:try_start_0 .. :try_end_0} :catch_1

    const/4 v4, 0x3

    const/4 v5, 0x1

    if-eqz v3, :cond_2

    if-ne p1, v5, :cond_0

    .line 643
    invoke-virtual {v3}, Landroid/app/admin/SystemUpdatePolicy;->getPolicyType()I

    move-result v6

    if-eq v6, v5, :cond_1

    :cond_0
    if-ne p1, v4, :cond_2

    .line 644
    invoke-virtual {v3}, Landroid/app/admin/SystemUpdatePolicy;->getPolicyType()I

    move-result v3

    if-ne v3, v4, :cond_2

    :cond_1
    return-void

    :cond_2
    if-eq p1, v5, :cond_8

    const/4 v3, 0x2

    if-eq p1, v3, :cond_4

    if-eq p1, v4, :cond_3

    const/4 p1, 0x0

    goto :goto_0

    .line 673
    :cond_3
    invoke-static {}, Landroid/app/admin/SystemUpdatePolicy;->createPostponeInstallPolicy()Landroid/app/admin/SystemUpdatePolicy;

    move-result-object p1

    goto :goto_0

    :cond_4
    if-eqz p2, :cond_7

    if-eqz p3, :cond_7

    .line 656
    invoke-static {p2}, Lcom/hmdm/launcher/util/Utils;->getMinutesFromString(Ljava/lang/String;)I

    move-result p1

    .line 657
    invoke-static {p3}, Lcom/hmdm/launcher/util/Utils;->getMinutesFromString(Ljava/lang/String;)I

    move-result p3

    const/4 v3, -0x1

    if-ne p1, v3, :cond_5

    .line 659
    new-instance p0, Ljava/lang/StringBuilder;

    const-string p1, "Ignoring scheduled system update policy: wrong start time: "

    invoke-direct {p0, p1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {v1, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    return-void

    :cond_5
    if-ne p3, v3, :cond_6

    .line 663
    new-instance p0, Ljava/lang/StringBuilder;

    const-string p1, "Ignoring scheduled system update policy: wrong end time: "

    invoke-direct {p0, p1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {v1, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    return-void

    .line 666
    :cond_6
    invoke-static {p1, p3}, Landroid/app/admin/SystemUpdatePolicy;->createWindowedInstallPolicy(II)Landroid/app/admin/SystemUpdatePolicy;

    move-result-object p1

    goto :goto_0

    .line 668
    :cond_7
    const-string p0, "Ignoring scheduled system update policy: update window is not set on server"

    invoke-static {v1, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    return-void

    .line 651
    :cond_8
    invoke-static {}, Landroid/app/admin/SystemUpdatePolicy;->createAutomaticInstallPolicy()Landroid/app/admin/SystemUpdatePolicy;

    move-result-object p1

    .line 677
    :goto_0
    :try_start_1
    invoke-virtual {v2, p0, p1}, Landroid/app/admin/DevicePolicyManager;->setSystemUpdatePolicy(Landroid/content/ComponentName;Landroid/app/admin/SystemUpdatePolicy;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    return-void

    :catch_0
    move-exception p0

    .line 679
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {v1, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    return-void

    :catch_1
    move-exception p0

    .line 638
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0}, Ljava/lang/NoSuchMethodError;->getMessage()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {v1, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method public static setTimeZone(Ljava/lang/String;Landroid/content/Context;)Z
    .locals 4

    .line 1088
    invoke-static {p1}, Lcom/hmdm/launcher/util/Utils;->isDeviceOwner(Landroid/content/Context;)Z

    move-result v0

    const/4 v1, 0x1

    if-eqz v0, :cond_2

    if-eqz p0, :cond_2

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1c

    if-ge v0, v2, :cond_0

    goto :goto_0

    .line 1093
    :cond_0
    :try_start_0
    const-string v0, "device_policy"

    invoke-virtual {p1, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/admin/DevicePolicyManager;

    .line 1095
    invoke-static {p1}, Lcom/hmdm/launcher/util/LegacyUtils;->getAdminComponentName(Landroid/content/Context;)Landroid/content/ComponentName;

    move-result-object p1

    .line 1097
    const-string v2, "auto"

    invoke-virtual {p0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const-string v3, "auto_time_zone"

    if-eqz v2, :cond_1

    .line 1099
    :try_start_1
    const-string p0, "1"

    invoke-virtual {v0, p1, v3, p0}, Landroid/app/admin/DevicePolicyManager;->setGlobalSetting(Landroid/content/ComponentName;Ljava/lang/String;Ljava/lang/String;)V

    return v1

    .line 1101
    :cond_1
    const-string v2, "0"

    invoke-virtual {v0, p1, v3, v2}, Landroid/app/admin/DevicePolicyManager;->setGlobalSetting(Landroid/content/ComponentName;Ljava/lang/String;Ljava/lang/String;)V

    .line 1102
    invoke-virtual {v0, p1, p0}, Landroid/app/admin/DevicePolicyManager;->setTimeZone(Landroid/content/ComponentName;Ljava/lang/String;)Z

    move-result p0
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    return p0

    :catch_0
    move-exception p0

    .line 1105
    invoke-virtual {p0}, Ljava/lang/Exception;->printStackTrace()V

    :cond_2
    :goto_0
    return v1
.end method

.method public static setVolume(ILandroid/content/Context;)Z
    .locals 5

    const/4 v0, 0x3

    const/4 v1, 0x4

    const/4 v2, 0x0

    const/4 v3, 0x1

    const/4 v4, 0x2

    .line 995
    filled-new-array {v2, v3, v4, v0, v1}, [I

    move-result-object v0

    .line 1003
    :try_start_0
    const-string v1, "audio"

    invoke-virtual {p1, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/media/AudioManager;

    move v1, v2

    :goto_0
    const/4 v4, 0x5

    if-ge v1, v4, :cond_0

    .line 1004
    aget v4, v0, v1

    .line 1005
    invoke-static {p1, v4, p0}, Lcom/hmdm/launcher/util/Utils;->setVolumeInternal(Landroid/media/AudioManager;II)V

    .line 1007
    invoke-virtual {p1, v4}, Landroid/media/AudioManager;->getStreamVolume(I)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    return v3

    :catch_0
    move-exception p0

    .line 1014
    new-instance p1, Ljava/lang/StringBuilder;

    const-string v0, "Failed to set volume: "

    invoke-direct {p1, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const-string v0, "HeadwindMDM"

    invoke-static {v0, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 1015
    invoke-virtual {p0}, Ljava/lang/Exception;->printStackTrace()V

    return v2
.end method

.method private static setVolumeInternal(Landroid/media/AudioManager;II)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 1021
    invoke-virtual {p0, p1}, Landroid/media/AudioManager;->getStreamMaxVolume(I)I

    move-result v0

    mul-int/2addr v0, p2

    .line 1022
    div-int/lit8 v0, v0, 0x64

    const/4 p2, 0x0

    .line 1023
    invoke-virtual {p0, p1, v0, p2}, Landroid/media/AudioManager;->setStreamVolume(III)V

    return-void
.end method

.method public static startRemoteAccessApp(Landroid/content/Context;Ljava/lang/String;)V
    .locals 3

    const-string v0, "Remote access app started: "

    .line 308
    invoke-static {p1}, Lcom/hmdm/launcher/util/Utils;->resolveRemoteAccessPackage(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_1

    .line 309
    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_1

    invoke-static {p0, p1}, Lcom/hmdm/launcher/util/Utils;->isPackageInstalled(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    goto :goto_0

    .line 313
    :cond_0
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    invoke-virtual {v1, p1}, Landroid/content/pm/PackageManager;->getLaunchIntentForPackage(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v1

    if-eqz v1, :cond_1

    const/high16 v2, 0x10000000

    .line 315
    invoke-virtual {v1, v2}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 316
    invoke-virtual {p0, v1}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    .line 317
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const/4 v0, 0x3

    invoke-static {p0, v0, p1}, Lcom/hmdm/launcher/util/RemoteLogger;->log(Landroid/content/Context;ILjava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p0

    .line 320
    invoke-virtual {p0}, Ljava/lang/Exception;->printStackTrace()V

    :cond_1
    :goto_0
    return-void
.end method

.method public static startStableForegroundService(Landroid/app/Service;ILandroid/app/Notification;)V
    .locals 2

    .line 1455
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1d

    if-lt v0, v1, :cond_1

    .line 1456
    invoke-static {p0}, Lcom/hmdm/launcher/util/Utils;->isDeviceOwner(Landroid/content/Context;)Z

    move-result v0

    const/high16 v1, 0x40000000    # 2.0f

    if-eqz v0, :cond_0

    const/16 v0, 0x400

    goto :goto_0

    :cond_0
    move v0, v1

    .line 1460
    :goto_0
    :try_start_0
    invoke-virtual {p0, p1, p2, v0}, Landroid/app/Service;->startForeground(ILandroid/app/Notification;I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    .line 1462
    :catch_0
    invoke-virtual {p0, p1, p2, v1}, Landroid/app/Service;->startForeground(ILandroid/app/Notification;I)V

    :goto_1
    return-void

    .line 1465
    :cond_1
    invoke-virtual {p0, p1, p2}, Landroid/app/Service;->startForeground(ILandroid/app/Notification;)V

    return-void
.end method

.method public static unlockUserRestrictions(Landroid/content/Context;Ljava/lang/String;)V
    .locals 4

    .line 1340
    invoke-static {p0}, Lcom/hmdm/launcher/util/LegacyUtils;->getAdminComponentName(Landroid/content/Context;)Landroid/content/ComponentName;

    move-result-object v0

    .line 1341
    const-string v1, "device_policy"

    invoke-virtual {p0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/app/admin/DevicePolicyManager;

    if-eqz v1, :cond_1

    .line 1342
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v1, p0}, Landroid/app/admin/DevicePolicyManager;->isDeviceOwnerApp(Ljava/lang/String;)Z

    move-result p0

    if-nez p0, :cond_0

    goto :goto_1

    .line 1346
    :cond_0
    const-string p0, ","

    invoke-virtual {p1, p0}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object p0

    .line 1347
    array-length p1, p0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, p1, :cond_1

    aget-object v3, p0, v2

    .line 1349
    :try_start_0
    invoke-virtual {v3}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v0, v3}, Landroid/app/admin/DevicePolicyManager;->clearUserRestriction(Landroid/content/ComponentName;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_1
    :goto_1
    return-void
.end method

.method public static withoutProtectiveRestrictions(Ljava/lang/String;)Ljava/lang/String;
    .locals 6

    if-nez p0, :cond_0

    .line 110
    const-string p0, ""

    return-object p0

    .line 112
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 113
    const-string v1, ","

    invoke-virtual {p0, v1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object p0

    array-length v2, p0

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v2, :cond_4

    aget-object v4, p0, v3

    .line 114
    invoke-virtual {v4}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v4

    .line 115
    invoke-virtual {v4}, Ljava/lang/String;->isEmpty()Z

    move-result v5

    if-nez v5, :cond_3

    sget-object v5, Lcom/hmdm/launcher/util/Utils;->PROTECTIVE_RESTRICTIONS:Ljava/util/Set;

    invoke-interface {v5, v4}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_1

    goto :goto_1

    .line 118
    :cond_1
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->length()I

    move-result v5

    if-lez v5, :cond_2

    .line 119
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 121
    :cond_2
    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_3
    :goto_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 123
    :cond_4
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static writeStringToFile(Ljava/lang/String;Ljava/lang/String;Z)Z
    .locals 2

    const/4 v0, 0x0

    .line 1429
    :try_start_0
    new-instance v1, Ljava/io/File;

    invoke-direct {v1, p0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 1430
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result p0

    if-eqz p0, :cond_1

    if-eqz p2, :cond_0

    .line 1432
    invoke-virtual {v1}, Ljava/io/File;->delete()Z

    goto :goto_0

    :cond_0
    return v0

    .line 1438
    :cond_1
    :goto_0
    invoke-virtual {v1}, Ljava/io/File;->createNewFile()Z

    .line 1439
    new-instance p0, Ljava/io/FileOutputStream;

    invoke-direct {p0, v1}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    .line 1440
    new-instance p2, Ljava/io/OutputStreamWriter;

    invoke-direct {p2, p0}, Ljava/io/OutputStreamWriter;-><init>(Ljava/io/OutputStream;)V

    .line 1441
    invoke-virtual {p2, p1}, Ljava/io/OutputStreamWriter;->append(Ljava/lang/CharSequence;)Ljava/io/Writer;

    .line 1442
    invoke-virtual {p2}, Ljava/io/OutputStreamWriter;->close()V

    .line 1443
    invoke-virtual {p0}, Ljava/io/FileOutputStream;->close()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const/4 p0, 0x1

    return p0

    :catch_0
    return v0
.end method
