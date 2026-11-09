.class Lcom/hmdm/launcher/service/StatusBarOverlayService$1;
.super Ljava/lang/Object;
.source "StatusBarOverlayService.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/hmdm/launcher/service/StatusBarOverlayService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/hmdm/launcher/service/StatusBarOverlayService;


# direct methods
.method constructor <init>(Lcom/hmdm/launcher/service/StatusBarOverlayService;)V
    .locals 0

    .line 70
    iput-object p1, p0, Lcom/hmdm/launcher/service/StatusBarOverlayService$1;->this$0:Lcom/hmdm/launcher/service/StatusBarOverlayService;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .line 73
    iget-object v0, p0, Lcom/hmdm/launcher/service/StatusBarOverlayService$1;->this$0:Lcom/hmdm/launcher/service/StatusBarOverlayService;

    invoke-static {v0}, Lcom/hmdm/launcher/service/StatusBarOverlayService;->access$000(Lcom/hmdm/launcher/service/StatusBarOverlayService;)V

    .line 74
    iget-object v0, p0, Lcom/hmdm/launcher/service/StatusBarOverlayService$1;->this$0:Lcom/hmdm/launcher/service/StatusBarOverlayService;

    invoke-static {v0}, Lcom/hmdm/launcher/service/StatusBarOverlayService;->access$100(Lcom/hmdm/launcher/service/StatusBarOverlayService;)Landroid/os/Handler;

    move-result-object v0

    const-wide/16 v1, 0x2710

    invoke-virtual {v0, p0, v1, v2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void
.end method
