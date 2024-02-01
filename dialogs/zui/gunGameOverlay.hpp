class GunGameOverlay: ZUI_ColumnLayout
{
	class container: ZUI_RowLayout
	{
		height = 0.5;
		heightType = ZUI_SIZE_ABSOLUTE;

		class weapons: ZUI_StructuredText
		{
			id = "weapons";
		};
	};
};
