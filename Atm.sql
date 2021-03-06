use [ATM_DB]
go
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[customer]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[customer](
	[c_name] [varchar](50) NULL,
	[user_name] [varchar](50) NULL,
	[address] [varchar](50) NULL,
	[phone] [varchar](50) NULL,
	[pin_code] [varchar](50) NULL,
	[account_no] [varchar](50) NOT NULL,
	[balance] [decimal](18, 3) NULL,
 CONSTRAINT [PK_customer] PRIMARY KEY CLUSTERED 
(
	[account_no] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[diposit_history]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[diposit_history](
	[account_no] [varchar](50) NULL,
	[date] [datetime] NULL,
	[ammount] [decimal](18, 3) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[withdraw_history]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[withdraw_history](
	[account_no] [varchar](50) NULL,
	[date] [datetime] NULL,
	[ammount] [decimal](18, 3) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[transfer_history]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[transfer_history](
	[date] [datetime] NULL,
	[acc_from] [varchar](50) NULL,
	[acc_to] [varchar](50) NULL,
	[ammount] [decimal](18, 3) NULL,
	[notification] [int] NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_diposit_history_customer]') AND parent_object_id = OBJECT_ID(N'[dbo].[diposit_history]'))
ALTER TABLE [dbo].[diposit_history]  WITH CHECK ADD  CONSTRAINT [FK_diposit_history_customer] FOREIGN KEY([account_no])
REFERENCES [dbo].[customer] ([account_no])
GO
ALTER TABLE [dbo].[diposit_history] CHECK CONSTRAINT [FK_diposit_history_customer]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_withdraw_history_customer]') AND parent_object_id = OBJECT_ID(N'[dbo].[withdraw_history]'))
ALTER TABLE [dbo].[withdraw_history]  WITH CHECK ADD  CONSTRAINT [FK_withdraw_history_customer] FOREIGN KEY([account_no])
REFERENCES [dbo].[customer] ([account_no])
GO
ALTER TABLE [dbo].[withdraw_history] CHECK CONSTRAINT [FK_withdraw_history_customer]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_transfer_history_customer]') AND parent_object_id = OBJECT_ID(N'[dbo].[transfer_history]'))
ALTER TABLE [dbo].[transfer_history]  WITH CHECK ADD  CONSTRAINT [FK_transfer_history_customer] FOREIGN KEY([acc_from])
REFERENCES [dbo].[customer] ([account_no])
GO
ALTER TABLE [dbo].[transfer_history] CHECK CONSTRAINT [FK_transfer_history_customer]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_transfer_history_customer1]') AND parent_object_id = OBJECT_ID(N'[dbo].[transfer_history]'))
ALTER TABLE [dbo].[transfer_history]  WITH CHECK ADD  CONSTRAINT [FK_transfer_history_customer1] FOREIGN KEY([acc_to])
REFERENCES [dbo].[customer] ([account_no])
GO
ALTER TABLE [dbo].[transfer_history] CHECK CONSTRAINT [FK_transfer_history_customer1]
