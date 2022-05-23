Public Class Payload
    Private Sub Settings_Load(sender As Object, e As EventArgs) Handles Me.Load
        Me.CenterToScreen()
        Me.BringToFront()
    End Sub
    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Close()
    End Sub
End Class
